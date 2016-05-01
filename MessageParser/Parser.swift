//
//  Parser.swift
//  MessageParser
//
//  Created by Filippos Zampounis on 29/04/16.
//  Copyright © 2016 Filippos Zampounis. All rights reserved.
//

import Foundation

enum Entity {
    case Mention(String)
    case Emoticon(String)
    case Link([String:String])
}

var emoticonParser     = EmoticonParser()
var mentionParser      = MentionParser()
var linkParser         = LinkParser()
var entitiesDictionary = [String:[Entity]]()

protocol EntitiesParser {
    var entitiesStack: [Entity] {get}
    func parseEntitiesInText(text:String)
}

protocol EntitiesParserDelegate: class{
    func htmlTitlesDidFetch()
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
        entitiesDictionary["mentions"]  = mentionParser.entitiesStack
        entitiesDictionary["emoticons"] = emoticonParser.entitiesStack
        entitiesDictionary["links"]     = linkParser.entitiesStack

        
        print("number of links: \(linkParser.numberOfEntities()), number of emoticons: \(emoticonParser.numberOfEntities()), number of mentions \(mentionParser.numberOfEntities())")

        print(entitiesDictionary)
    }
    
    func jsonResults() {
    
    }
}
