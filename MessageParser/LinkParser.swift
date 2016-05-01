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
            
            guard let url = NSURL(string: link) else {
                self.entitiesStack.append(Entitiy.Link([link, ""]))
                return
            }
            
            let request = NSMutableURLRequest(URL:url)
            
            NSURLSession.sharedSession().dataTaskWithRequest(request) {
                
                (data, response, error) in
                
                if (error == nil) {
                    let datastring = String(data: data!, encoding: NSASCIIStringEncoding)
                    let title = datastring!.sliceFrom("<title>", to: "</title>")!
                    self.entitiesStack.append(Entitiy.Link([link, title]))
                } else {
                    self.entitiesStack.append(Entitiy.Link([link, ""]))
                }
                
            }.resume()
        }
    }
}

extension String {
    func sliceFrom(start: String, to: String) -> String? {
        return (rangeOfString(start)?.endIndex).flatMap { sInd in
            (rangeOfString(to, range: sInd..<endIndex)?.startIndex).map { eInd in
                substringWithRange(sInd..<eInd)
            }
        }
    }
}
