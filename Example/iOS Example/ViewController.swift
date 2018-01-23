//
//  ViewController.swift
//  iOS Example
//
//  Created by Sameer Khavanekar on 1/22/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import UIKit
import EtherS
import Geth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let value = GethNewBigInt(5)!
        
        let ethFunction = EthFunction(name: "sam", inputParameters: [value])
        let encodedData = EtherS.encode(ethFunction)
        
        print("Encoded function data is \(encodedData.toHexString())")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

