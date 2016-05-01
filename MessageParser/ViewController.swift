//
//  ViewController.swift
//  MessageParser
//
//  Created by Filippos Zampounis on 28/04/16.
//  Copyright © 2016 Filippos Zampounis. All rights reserved.
//

import UIKit

protocol parseCompleteDelegate: class{
    func parsingDidFinish(dict:[String:[Entity]])
}

class ViewController: UIViewController, parseCompleteDelegate {
    
    let parser = Parser()
    
    @IBOutlet weak var inputField: UITextField!

    @IBAction func ParseMessage() {
        parser.parseEntitiesInText(inputField.text!);
    }
    
    func parsingDidFinish (dict:[String:[Entity]]) {
        print(dict)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parser.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

