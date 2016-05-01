//
//  EmoticonParser.swift
//  MessageParser
//
//  Created by Filippos Zampounis on 30/04/16.
//  Copyright © 2016 Filippos Zampounis. All rights reserved.
//

import Foundation

class EmoticonParser: EntitiesParser {

    let emoticonRegex = "(?<=\\()[^()]{1,15}(?=\\))"
    var entitiesStack = [Entity]()
    var delegate: EntitiesParserDelegate?
    
    func parseEntitiesInText (text:String) {
        extractEmoticonsInText(text);
    }
    
    func numberOfEntities () -> Int {
        return entitiesStack.count;
    }
    
    func clearEntities () {
        self.entitiesStack = []
    }

    private func extractEmoticonsInText (text:String) {
        
        let regex   = try! NSRegularExpression(pattern: emoticonRegex, options: [])
        let range   = NSMakeRange(0, (text as NSString).length)
        
        regex.enumerateMatchesInString(text, options:NSMatchingOptions.ReportCompletion, range: range)
        {
            (result, _, _) in

            if (result == nil) {
                // completed
                self.delegate?.entitiesDidFetch("Emoticons")
                return;
            }

            let emoticon = (text as NSString).substringWithRange(result!.range)
            
            self.entitiesStack.append(Entity.Emoticon(emoticon))
        }
    }
}
