//
//  ViewController.swift
//  MessageParser
//
//  Created by Filippos Zampounis on 28/04/16.
//  Copyright © 2016 Filippos Zampounis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let parser = Parser()
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func ParseMessage() {
        parser.parseEntitiesInText(inputField.text!);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

