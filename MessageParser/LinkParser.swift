//
//  LinkParser.swift
//  MessageParser
//
//  Created by Filippos Zampounis on 30/04/16.
//  Copyright © 2016 Filippos Zampounis. All rights reserved.
//

import Foundation


class LinkParser: EntitiesParser {
    
    var entitiesStack = [Entity]()
    var delegate: EntitiesParserDelegate?

    internal var linksStack = [String]()
    
    func parseEntitiesInText (text:String) {
        extractLinksInText(text);
    }
    
    func numberOfEntities () -> Int {
        return entitiesStack.count;
    }
    
    private func extractLinksInText (text:String) {
        
        let detector = try! NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        let range    = NSMakeRange(0, (text as NSString).length)
        
        detector.enumerateMatchesInString(text, options:NSMatchingOptions.ReportCompletion, range: range)
        {
            (result, _, _) in
            if (result != nil) {
                let link = (text as NSString).substringWithRange(result!.range)
                self.linksStack.append(link)
            } else {
                self.extractTitleInHtml()
            }
        }
    }
    
    private func extractTitleInHtml () {
        
        for (index, link) in self.linksStack.enumerate() {
            
            guard let url = NSURL(string: link) else {
                continue;
            }
        
            let request = NSMutableURLRequest(URL:url)
        
            NSURLSession.sharedSession().dataTaskWithRequest(request) {
            
                (data, response, error) in
                if (error == nil) {
                    let datastring = String(data: data!, encoding: NSASCIIStringEncoding)
                    let title = datastring!.sliceFrom("<title>", to: "</title>")!

                    self.entitiesStack.append(Entity.Link(["url": link, "title": title]))
                } else {
                    self.entitiesStack.append(Entity.Link(["url": link]))
                }
                
                if (index == self.linksStack.count - 1) {
                    self.delegate?.entitiesDidFetch("Links")
                }
            }.resume()
        }
    }
}

extension String {
    func sliceFrom(start: String, to: String) -> String? {
        return (rangeOfString(start)?.endIndex).flatMap {
            sInd in
            
            (rangeOfString(to, range: sInd..<endIndex)?.startIndex).map {
                eInd in
                
                substringWithRange(sInd..<eInd)
            }
        }
    }
}
