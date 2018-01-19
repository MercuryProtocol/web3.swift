//
//  EthAccount.swift
//  Dust
//
//  Created by Sameer Khavanekar on 1/17/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import Foundation
import Geth

open class EthAcount: GethAccount {
    
    
    class func sign(address: GethAddress, encodedFunctionData: Data, nonce: Int64, gasLimit: GethBigInt, gasPrice: GethBigInt, keystore: GethKeyStore, account: GethAccount, passphrase: String) -> GethTransaction? {
        do {
            let amount = GethNewBigInt(0)
            if let newTransaction = GethNewTransaction(nonce, address, amount, gasLimit, gasPrice, encodedFunctionData) {
                try keystore.unlock(account, passphrase: passphrase)
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
