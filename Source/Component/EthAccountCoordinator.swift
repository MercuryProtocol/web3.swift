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
    public var namespace: String?
    public var password: String?
    
    public init(namespace: String?, password: String?) {
        self.namespace = namespace
        self.password = password
    }
    
    open static let `default`: EthAccountConfiguration = {
        return EthAccountConfiguration(namespace: "wallet", password: "qwerty")
    }()
    
}

open class EthAccountCoordinator {
    
    fileprivate var _keystore: GethKeyStore? = nil
    fileprivate var _account: GethAccount? = nil
    fileprivate var _gethContext: GethContext? = nil
    
    open var defaultConfiguration: EthAccountConfiguration = EthAccountConfiguration.default
    
    open static let `default`: EthAccountCoordinator = {
        return EthAccountCoordinator()
    }()
    
    
    open var keystore: GethKeyStore? {
        return _keystore
    }
    
    open var account: GethAccount? {
        return _account
    }
    
    open func setup(_ configuration: EthAccountConfiguration) -> (GethKeyStore?, GethAccount?) {
        defaultConfiguration = configuration
        _keystore = _createKeystore(configuration.namespace)
        
        guard let keystore = _keystore else {
            print("Failed to create keystore")
            return (nil, nil)
        }
        if let password = configuration.password {
            _account = _createAccount(keystore, password: password)
            return (_keystore, _account)
        } else {
            print("Account not created as password is not set")
        }
        return (_keystore, nil)
    }
    
    open func createAccount(_ password: String) -> GethAccount? {
        defaultConfiguration.password = password
        if _keystore == nil {
            _keystore = _createKeystore(defaultConfiguration.namespace)
        }
        guard let keystore = _keystore else {
            print("Failed to create keystore")
            return nil
        }
        _account = _createAccount(keystore, password: password)
        return _account
    }
    
    
    private func _createKeystore(_ atPath: String?) -> GethKeyStore? {
        let datadir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        var pathInfix = atPath ?? ""
        if !pathInfix.isEmpty {
            pathInfix = pathInfix + "/"
        }
        let finalPath = datadir + "/" + "\(pathInfix)" + "keystore"
        let keystore = GethNewKeyStore(finalPath, GethLightScryptN, GethLightScryptP)  // GethStandardScryptN, GethStandardScryptP, GethLightScryptN, GethLightScryptP or number
        _gethContext = GethNewContext()
        return keystore
    }
    
    
    fileprivate func _createAccount(_ keystore: GethKeyStore, password: String) -> GethAccount? {
        do {
            if let account = _getAccount(password) {
                return account
            } else {
                let account = try keystore.newAccount(password)
                return account
            }
        } catch {
            print("Failed to create account!")
            return nil
        }
    }
    
    // TODO:- Update later to handle multiple accounts for wallet
    
    private func _getAccount(_ password: String, at: Int = 0) -> GethAccount? {
        if let accounts = _keystore?.getAccounts() {
            do {
                let account: GethAccount? = try accounts.get(at)
                if let account = account {
                    try _keystore?.unlock(account, passphrase: password)
                }
                return account
            } catch {
                return nil
            }
        }
        return nil
    }
    
    
    open func drain() {
        _keystore = nil
        _account = nil
        _gethContext = nil
    }
    
}


public extension EthAccountCoordinator {
    
    public func sign(address: GethAddress, encodedFunctionData: Data, nonce: Int64, gasLimit: GethBigInt, gasPrice: GethBigInt) -> GethTransaction? {
        guard let password = defaultConfiguration.password else {
            print("Password not set")
            return nil
        }
        return sign(address: address, encodedFunctionData: encodedFunctionData, nonce: nonce, gasLimit: gasLimit, gasPrice: gasPrice, password: password)
    }
    
    public func sign(address: GethAddress, encodedFunctionData: Data, nonce: Int64, gasLimit: GethBigInt, gasPrice: GethBigInt, password: String) -> GethTransaction? {
        guard let keystore = _keystore, let account = _account else {
            // TODO:- We can return Error here/Throw one
            print("Create keystore/account first")
            return nil
        }
        
        do {
            let amount = GethNewBigInt(0)
            if let newTransaction = GethNewTransaction(nonce, address, amount, gasLimit, gasPrice, encodedFunctionData) {
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


