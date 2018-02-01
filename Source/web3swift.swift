//
//  Web3swift.swift
//  web3swift
//
//  Created by Sameer Khavanekar on 1/18/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import Foundation
import Geth

public func encode(_ function: EthFunction) -> Data {
    return EthFunctionEncoder.default.encode(function)
}

public func sign(address: GethAddress, encodedFunctionData: Data, nonce: Int64, gasLimit: GethBigInt, gasPrice: GethBigInt) -> GethTransaction? {
    return EthAccountCoordinator.default.sign(address: address, encodedFunctionData: encodedFunctionData, nonce: nonce, gasLimit: gasLimit, gasPrice: gasPrice)
}

public func sign(message: Data) -> SignatureData? {
    guard let defaultKeystore = EthAccountCoordinator.default.keystore, let defaultAccount = EthAccountCoordinator.default.account, let password = EthAccountCoordinator.default.defaultConfiguration.password else {
        print("Default Account not set, Please use Sign.sign instead")
        return nil
    }
    return Sign.sign(message: message, keystore: defaultKeystore, account: defaultAccount, passphrase: password)
}


