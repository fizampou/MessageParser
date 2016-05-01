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

protocol EntitiesParser {
    var entitiesStack: [Entity] {get}
    func parseEntitiesInText(text:String)
    func clearEntities ()
}

protocol EntitiesParserDelegate: class{
    func entitiesDidFetch(entity:String)
}

class Parser: EntitiesParserDelegate {
    
    var emoticonParser     = EmoticonParser()
    var mentionParser      = MentionParser()
    var linkParser         = LinkParser()
    var entitiesDictionary = [String:[Entity]]()
    var delegate: parseCompleteDelegate?

    init() {
        linkParser.delegate = self
        mentionParser.delegate = self
        emoticonParser.delegate = self
    }

    func parseEntitiesInText (text:String) {
        cleanResults()
        
        linkParser.parseEntitiesInText(text);
        emoticonParser.parseEntitiesInText(text);
        mentionParser.parseEntitiesInText(text);
    }
    
    func entitiesDidFetch(entity:String) {
        switch entity {
            case "Links":
                entitiesDictionary["links"] = linkParser.entitiesStack
            case "Mentions":
                entitiesDictionary["mentions"] = mentionParser.entitiesStack
            case "Emoticons":
                entitiesDictionary["emoticons"] = emoticonParser.entitiesStack
            default:
                print("wrong entity detected")
        }
        
        if (entitiesDictionary.keys.count == 3) {
            self.delegate?.parsingDidFinish(entitiesDictionary)
        }
    }
    
    func cleanResults() {
        entitiesDictionary = [:]
        linkParser.clearEntities()
        emoticonParser.clearEntities()
        mentionParser.clearEntities()
    }
}
