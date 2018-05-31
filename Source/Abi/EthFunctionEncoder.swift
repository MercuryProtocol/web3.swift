//
//  EthFunctionEncoder.swift
//  Dust
//
//  Created by Sameer Khavanekar on 1/15/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import Foundation
import CryptoSwift
import Geth

extension EthFunction {
    
    open func ethEncode() -> Data {
        let parameters = self.getInputParameters()

        let methodSignature = _buildMethodSignature(self.getName(), parameters: parameters)
        var methodId = _buildMethodId(methodSignature)
        
        print("EthFunctionEncoder : \(methodId.toHexString())")
        
        methodId.append(parameters.ethEncode())
        
        return methodId
    }
    
    
    open func encodeToValueTxFee(recipient: GethAddress, amount: GethBigInt, txFee: GethBigInt) -> Data {
        let addressEncoded = recipient.ethEncode()
        let amountEncoded = amount.ethEncode()
        let txFeeEncoded = txFee.ethEncode()
        
        var startIndex = 0
        for (index, byte) in addressEncoded.enumerated() {
            if byte != 0 {
                startIndex = index
                break
            }
        }
        let byteArray = addressEncoded.bytes[startIndex..<addressEncoded.bytes.count]
        var combinedData = Data(bytes: byteArray)
        
        combinedData.append(amountEncoded)
        combinedData.append(txFeeEncoded)
        print("Combined Data \(combinedData.bytes) hex \(combinedData.toHexString())")
        return combinedData
    }
    
    
  
    private func _buildMethodSignature(_ methodName: String, parameters: Array<EthEncodable>) -> String {
        var methodSignature = "\(methodName)("
        
        let params = parameters.map { (parameter) -> String in
            return parameter.typeString()
        }
        methodSignature += params.joined(separator: ",")
        methodSignature += ")"
        return methodSignature
    }

    private func _buildMethodId(_ methodSignature: String) -> Data {
        let functionSignatureData = methodSignature.data(using: .utf8)
        let signedFunctionSignature = functionSignatureData!.sha3(SHA3.Variant.keccak256)
        let range = Range(0..<4)
        return signedFunctionSignature.subdata(in: range) // format: - 0xa9059cbb
    }
    
}

