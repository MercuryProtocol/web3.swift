//
//  EthAccountCoordinator.swift
//  EtherS
//
//  Created by Sameer Khavanekar on 1/23/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import Foundation
import Geth

open class EthAccountConfiguration {
    public var username: String
    public var password: String
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    open static let `default`: EthAccountConfiguration = {
        return EthAccountConfiguration(username: "test", password: "qwerty")
    }()
    
}

open class EthAccountCoordinator {
    
    fileprivate var _keystore: GethKeyStore? = nil
    fileprivate var _account: GethAccount? = nil
    fileprivate var _gethContext: GethContext? = nil
    
    fileprivate var _configuaration: EthAccountConfiguration
    
    open static let `default`: EthAccountCoordinator = {
        return EthAccountCoordinator(EthAccountConfiguration.default)
    }()
    
    open var account: GethAccount? {
        return _account
    }
    
    public init(_ configuration: EthAccountConfiguration) {
        _configuaration = configuration
        _ = createAccount(configuration.password, at: configuration.username)
    }
    
    open func createAccount(_ password: String, at: String) -> GethAccount? {
        if _keystore == nil {
            _createKeystore(at)
        }
        return _createAccount(password)
    }
    
    
    private func _createKeystore(_ at: String) {
        let datadir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let finalPath = datadir + "/" + "\(at)" + "/keystore"
        _keystore = GethNewKeyStore(finalPath, GethLightScryptN, GethLightScryptP)  // GethStandardScryptN, GethStandardScryptP, GethLightScryptN, GethLightScryptP or number
        _gethContext = GethNewContext()
    }
    
    
    fileprivate func _createAccount(_ password: String) -> GethAccount? {
        do {
            if let account = _getAccount(password) {
                _account = account
            } else {
                _account = try _keystore?.newAccount(password)
            }
            return _account
        } catch {
            print("Failed to create account!")
            return nil
        }
    }
    
    // TODO:- Update later to handle multiple accounts for wallet
    
    private func _getAccount(_ password: String, at: Int = 0) -> GethAccount? {
        if let accounts = _keystore?.getAccounts() {
            do {
                _account = try accounts.get(at)
                if _account != nil {
                    try _keystore?.unlock(_account!, passphrase: password)
                }
                return _account
            } catch {
                return nil
            }
        }
        return nil
    }
    
    
}


public extension EthAccountCoordinator {
    
    open func sign(address: GethAddress, encodedFunctionData: Data, nonce: Int64, gasLimit: GethBigInt, gasPrice: GethBigInt) -> GethTransaction? {
        guard let keystore = _keystore, let account = _account else {
            // TODO:- We can return Error here/Throw one
            print("Create keystore/account first")
            return nil
        }
        
        do {
            let amount = GethNewBigInt(0)
            if let newTransaction = GethNewTransaction(nonce, address, amount, gasLimit, gasPrice, encodedFunctionData) {
                try keystore.unlock(account, passphrase: _configuaration.password)
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


