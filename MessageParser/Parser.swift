//
//  Parser.swift
//  MessageParser
//
//  Created by Filippos Zampounis on 29/04/16.
//  Copyright © 2016 Filippos Zampounis. All rights reserved.
//

import UIKit

class Parser {
    
    var entitiesStack = [String]()
    
    func parseEntitiesInText (text:String) {
        let numberOfLinks = extractLinksInText(text);
        
        let numberOfEmoticons = extractEmoticonsInText(text);
        
        let numberOfMentions = extractMentionsInText(text);
        
        print("number of links: \(numberOfLinks), number of emoticons: \(numberOfEmoticons), number of mentions \(numberOfMentions)")
        
        print(entitiesStack)
    }
    
    private func extractLinksInText (text:String) -> Int {
        
        let detector = try! NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        let range    = NSMakeRange(0, (text as NSString).length)
        var matches  = 0
        
        detector.enumerateMatchesInString(text, options: [], range: range)
        {
            (result, _, _) in
                self.entitiesStack.append((text as NSString).substringWithRange(result!.range))
                matches += 1
        }
        
        return matches
    }
    
    private func extractEmoticonsInText (text:String) -> Int {
        
        let regex   = try! NSRegularExpression(pattern: "(?<=\\()[^()]{1,15}(?=\\))", options: [])
        let range   = NSMakeRange(0, (text as NSString).length)
        var matches = 0
        
        regex.enumerateMatchesInString(text, options: [], range: range)
        {
            (result, _, _) in
                self.entitiesStack.append((text as NSString).substringWithRange(result!.range))
                matches += 1
        }
        
        return matches
    }
    
    private func extractMentionsInText (text:String) -> Int {

        let regex   = try! NSRegularExpression(pattern: "(?<=\\@)[A-Za-z0-9.-]+", options: [])
        let range   = NSMakeRange(0, (text as NSString).length)
        var matches = 0
        
        regex.enumerateMatchesInString(text, options: [], range: range)
        {
            (result, _, _) in
            self.entitiesStack.append((text as NSString).substringWithRange(result!.range))
            matches += 1
        }
        
        return matches
    }

}
