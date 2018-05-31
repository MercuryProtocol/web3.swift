//
//  SignatureData.swift
//  web3swift
//
//  Created by Sameer Khavanekar on 1/31/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import Foundation
import CryptoSwift

public struct SignatureData {
    private var _v: Int
    private var _r: Data
    private var _s: Data
    
    public var v: String {
        return String(_v)
    }
    public var r: String {
        return _r.toHexString()
    }
    public var s: String {
        return _s.toHexString()
    }
    
    init(v: Int, r: Data, s: Data) {
        _v = v
        _r = r
        _s = s
    }
    
    
    
    
}
