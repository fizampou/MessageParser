//
//  ViewController.swift
//  MessageParser
//
//  Created by Filippos Zampounis on 28/04/16.
//  Copyright © 2016 Filippos Zampounis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parser = Parser()
        
        parser.parseEntitiesInText("this is a normal text https://www.in.gr this is a normal text https://google.cz (shit) (happens) ((skata)) (skataskataskata) (skataskataska) (skataskataskat) (1221211212121) (3122121121212122)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

