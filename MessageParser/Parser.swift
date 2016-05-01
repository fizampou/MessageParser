//
//  Parser.swift
//  MessageParser
//
//  Created by Filippos Zampounis on 29/04/16.
//  Copyright © 2016 Filippos Zampounis. All rights reserved.
//

import Foundation

var emoticonParser = EmoticonParser()
var mentionParser  = MentionParser()
var linkParser     = LinkParser()

protocol EntitiesParser {
    var entitiesStack: [Entitiy] {get}
    func parseEntitiesInText(text:String)
}

protocol EntitiesParserDelegate: class{
    func htmlTitlesDidFetch()
}

enum Entitiy {
    case Mention(String)
    case Emoticon(String)
    case Link([String])
}

class Parser: EntitiesParserDelegate {

    init() {
        linkParser.delegate = self
    }

    func parseEntitiesInText (text:String) {
        
        linkParser.parseEntitiesInText(text);
        emoticonParser.parseEntitiesInText(text);
        mentionParser.parseEntitiesInText(text);
    
    }
    
    func htmlTitlesDidFetch() {
        print("number of links: \(linkParser.numberOfEntities()), number of emoticons: \(emoticonParser.numberOfEntities()), number of mentions \(mentionParser.numberOfEntities())")

        print(Array([linkParser.entitiesStack, emoticonParser.entitiesStack, mentionParser.entitiesStack].flatten()))
    }
}
