//
//  ViewController.swift
//  MessageParser
//
//  Created by Filippos Zampounis on 28/04/16.
//  Copyright © 2016 Filippos Zampounis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var parser : Parser!
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func ParseMessage() {
        parser.parseEntitiesInText(inputField.text!);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parser = Parser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

