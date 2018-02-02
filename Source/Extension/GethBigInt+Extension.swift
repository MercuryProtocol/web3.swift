//
//  GethBigInt+Extension.swift
//  web3swift
//
//  Created by Sameer Khavanekar on 1/24/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import Foundation
import Geth

public extension GethBigInt {
    
    public static func bigInt(valueInEther: Int64) -> GethBigInt? {
        return bigInt(String(valueInEther))
    }
    
    public static func bigInt(_ valueInEther: String) -> GethBigInt? {
        let amountInWei = "\(valueInEther)000000000000000000"
        
        let result = GethNewBigInt(0)
        result?.setString(amountInWei, base: 10)
        return result
    }
    
    public var decimalString: String {
        return self.getString(10)
    }
    
    
    
}
