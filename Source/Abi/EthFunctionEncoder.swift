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

open class EthFunctionEncoder {
    
    open static let `default`: EthFunctionEncoder = {
        return EthFunctionEncoder()
    }()
    
    open func encode(_ function: EthFunction) -> Data {
        let parameters = function.getInputParameters()

        let methodSignature = buildMethodSignature(function.getName(), parameters: parameters)
        let methodId = buildMethodId(methodSignature)
        
        print("EthFunctionEncoder : \(methodId.toHexString())")
        return encodeParameters(parameters, methodData: methodId)
    }
    
    
    open func encodeToValueTxFee(recipient: GethAddress, amount: GethBigInt, txFee: GethBigInt) -> Data {
        let addressEncoded = try! EthTypeEncoder.default.encode(recipient)
        let amountEncoded = try! EthTypeEncoder.default.encode(amount)
        let txFeeEncoded = try! EthTypeEncoder.default.encode(txFee)
        
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
    
    open func encodeParameters(_ parameters: Array<Any>, methodData: Data) -> Data {
        var result = methodData
        let dynamicDataOffset: Int = _getLength(parameters) * EthType.MAX_BYTE_LENGTH
        
        for parameter in parameters {
            let encodedValue = try! EthTypeEncoder.default.encode(parameter)
            
            if EthTypeEncoder.isDynamic(parameter) {
                let encodedDataOffset = EthTypeEncoder.default.encode(dynamicDataOffset)
                print("Encoded Offset \(encodedDataOffset.bytes)")
                print("Encoded Offset hex \(encodedDataOffset.bytes.toHexString())")
                result.append(encodedDataOffset)
                let encodedParameter = try! EthTypeEncoder.default.encode(parameter)
                result.append(encodedParameter)
            } else {
                result.append(encodedValue)
            }
        }
        return result
    }
  
    private func buildMethodSignature(_ methodName: String, parameters: Array<Any>) -> String {
        var methodSignature = "\(methodName)("
        
        let params = parameters.map { (parameter) -> String in
            return EthType.getTypeAsString(parameter)
        }
        methodSignature += params.joined(separator: ",")
        methodSignature += ")"
        return methodSignature
    }
    
    private func _getLength(_ parameters: Array<Any>) -> Int {
        var count = 0
        for parameter in parameters {
            if parameter is Array<Any> {
                count += (parameter as! Array<Any>).count // TODO: - We need to look at this
            } else {
                count += 1
            }
        }
        return count
    }

    private func buildMethodId(_ methodSignature: String) -> Data {
        let functionSignatureData = methodSignature.data(using: .utf8)
        let signedFunctionSignature = functionSignatureData!.sha3(SHA3.Variant.keccak256)
        let range = Range(0..<4)
        return signedFunctionSignature.subdata(in: range) // format: - 0xa9059cbb
    }
    
}

