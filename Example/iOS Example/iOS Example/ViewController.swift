//
//  ViewController.swift
//  iOS Example
//
//  Created by Sameer Khavanekar on 1/19/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import UIKit
import EtherS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        EtherS.sign()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

