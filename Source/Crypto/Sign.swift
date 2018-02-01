//
//  Sign.swift
//  web3swift
//
//  Created by Sameer Khavanekar on 1/31/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import Foundation
import Geth

open class Sign {
    
    open class func sign(message: Data, keystore: GethKeyStore, accountAddress: GethAddress) -> SignatureData? {
        let hashedMessage = message.sha3(SHA3.Variant.keccak256)
        
        do {
            let hashedSignedMessage = try keystore.signHash(accountAddress, hash: hashedEncodedMessage)
            let r = encodedTargetSignedFunction.subdata(in: Range(0..<32))
            let s = encodedTargetSignedFunction.subdata(in: Range(32..<64))
            let v = encodedTargetSignedFunction.subdata(in: Range(64..<65)) // TODO:- Use length
            
            let finalV = Int(v.toHexString()) + 27
            
            return SignatureData(v: finalV, r: r, s: s)
            
        } catch {
            print("Failed to signhash \(error)")
            return nil
        }
    }
    
    
}
