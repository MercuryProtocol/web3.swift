//
//  Sign.swift
//  web3swift
//
//  Created by Sameer Khavanekar on 1/31/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import Foundation
import Geth
import CryptoSwift

open class Sign {
    
    open class func sign(message: Data, keystore: GethKeyStore, account: GethAccount, passphrase: String) -> SignatureData? {
        let hashedMessage = message.sha3(SHA3.Variant.keccak256)
        
        do {
            // TODO:- Add timed Unlock
            _ = try? keystore.unlock(account, passphrase: passphrase)
            let accountAddress = account.getAddress()
            let hashedSignedMessage = try keystore.signHash(accountAddress, hash: hashedMessage)
            let r = hashedSignedMessage.subdata(in: Range(0..<32))
            let s = hashedSignedMessage.subdata(in: Range(32..<64))
            let v = hashedSignedMessage.subdata(in: Range(64..<65)) // TODO:- Use length
        
            if let recId = Int(v.toHexString()) {
                let headerByte = recId + 27
                return SignatureData(v: headerByte, r: r, s: s)
            } else {
                return nil
            }
        } catch {
            print("Failed to signhash \(error)")
            return nil
        }
    }
    
    
    open class func sign(keystore: GethKeyStore, account: GethAccount, address: GethAddress, encodedFunctionData: Data, nonce: Int64, gasLimit: GethBigInt, gasPrice: GethBigInt, password: String) -> GethTransaction? {
        do {
            let amount = GethNewBigInt(0)
            if let newTransaction = GethNewTransaction(nonce, address, amount, gasLimit.getInt64(), gasPrice, encodedFunctionData) {
                // TODO:- Add timed Unlock
                try keystore.unlock(account, passphrase: password)
                let finalTransaction = try keystore.signTx(account, tx: newTransaction, chainID: nil)
                return finalTransaction
            } else {
                print("Failed to create new transaction")
                return nil
            }
        } catch {
            print("Failed to sign transaction")
            return nil
        }
    }
    
    
}
