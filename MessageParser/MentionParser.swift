//
//  MentionParser.swift
//  MessageParser
//
//  Created by Filippos Zampounis on 30/04/16.
//  Copyright © 2016 Filippos Zampounis. All rights reserved.
//

import Foundation

class MentionParser: EntitiesParser {
    
    let mentionRegex = "(?<=\\@)[A-Za-z0-9.-]+"
    var entitiesStack = [Entity]()
    var delegate: EntitiesParserDelegate?
    
    func parseEntitiesInText (text:String) {
        extractMentionsInText(text);
    }
    
    func numberOfEntities () -> Int {
        return entitiesStack.count;
    }
    
    func clearEntities () {
        self.entitiesStack = []
    }
    
    private func extractMentionsInText (text:String) {
        
        let regex   = try! NSRegularExpression(pattern: mentionRegex, options: [])
        let range   = NSMakeRange(0, (text as NSString).length)
        
        regex.enumerateMatchesInString(text, options:NSMatchingOptions.ReportCompletion, range: range)
        {
            (result, _, _) in
            
            if (result == nil) {
                // completed
                self.delegate?.entitiesDidFetch("Mentions")
                return;
            }
            
            let mention = (text as NSString).substringWithRange(result!.range)
            
            self.entitiesStack.append(Entity.Mention(mention))
        }
    }
}
