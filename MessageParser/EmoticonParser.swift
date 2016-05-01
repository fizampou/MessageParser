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
    var entitiesStack = [Entitiy]()
    
    func parseEntitiesInText (text:String) {
        extractEmoticonsInText(text);
    }
    
    func numberOfEntities () -> Int {
        return entitiesStack.count;
    }

    private func extractEmoticonsInText (text:String) {
        
        let regex   = try! NSRegularExpression(pattern: emoticonRegex, options: [])
        let range   = NSMakeRange(0, (text as NSString).length)
        
        regex.enumerateMatchesInString(text, options: [], range: range)
        {
            (result, _, _) in
            let emoticon = (text as NSString).substringWithRange(result!.range)
            
            self.entitiesStack.append(Entitiy.Emoticon(emoticon))
        }
    }
}
