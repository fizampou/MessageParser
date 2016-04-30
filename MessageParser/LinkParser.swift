//
//  LinkParser.swift
//  MessageParser
//
//  Created by Filippos Zampounis on 30/04/16.
//  Copyright © 2016 Filippos Zampounis. All rights reserved.
//

import Foundation

class LinkParser: EntitiesParser {
    
    var entitiesStack = [Entitiy]()
    
    func parseEntitiesInText (text:String) {
        extractLinksInText(text);
    }
    
    func numberOfEntities () -> Int {
        return entitiesStack.count;
    }
    
    private func extractLinksInText (text:String) {
        
        let detector = try! NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        let range    = NSMakeRange(0, (text as NSString).length)
        
        detector.enumerateMatchesInString(text, options: [], range: range)
        {
            (result, _, _) in
            let link = (text as NSString).substringWithRange(result!.range)
            
            self.entitiesStack.append(Entitiy.Link(link){$0})
        }
    }

}
