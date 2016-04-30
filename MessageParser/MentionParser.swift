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
    var entitiesStack = [Entitiy]()
    
    func parseEntitiesInText (text:String) {
        extractMentionsInText(text);
    }
    
    func numberOfEntities () -> Int {
        return entitiesStack.count;
    }
    
    private func extractMentionsInText (text:String) {
        
        let regex   = try! NSRegularExpression(pattern: mentionRegex, options: [])
        let range   = NSMakeRange(0, (text as NSString).length)
        
        regex.enumerateMatchesInString(text, options: [], range: range)
        {
            (result, _, _) in
            let mention = (text as NSString).substringWithRange(result!.range)
            
            self.entitiesStack.append(Entitiy.Mention(mention))
        }
    }
}
