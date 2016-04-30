//
//  Parser.swift
//  MessageParser
//
//  Created by Filippos Zampounis on 29/04/16.
//  Copyright © 2016 Filippos Zampounis. All rights reserved.
//

import UIKit

var emoticonParser = EmoticonParser()
var mentionParser  = MentionParser()
var linkParser     = LinkParser()

protocol EntitiesParser {
    var entitiesStack: [Entitiy] {get}
    func parseEntitiesInText(text:String)
}

enum Entitiy {
    case Mention(String)
    case Emoticon(String)
    case Link(String, (String) -> String)
}

class Parser : EntitiesParser {
    
    var entitiesStack = [Entitiy]()
    
    func parseEntitiesInText (text:String) {
        linkParser.parseEntitiesInText(text);
        let numberOfLinks = linkParser.numberOfEntities()
            
        emoticonParser.parseEntitiesInText(text);
        let numberOfEmoticons = emoticonParser.numberOfEntities()
        
        mentionParser.parseEntitiesInText(text);
        let numberOfMentions = mentionParser.numberOfEntities()
        
        print("number of links: \(numberOfLinks), number of emoticons: \(numberOfEmoticons), number of mentions \(numberOfMentions)")
        
        entitiesStack = Array([linkParser.entitiesStack, emoticonParser.entitiesStack, mentionParser.entitiesStack].flatten())
        
        print(entitiesStack)
    }
}
