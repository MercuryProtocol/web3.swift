//
//  EthTypeEncoder.swift
//  Dust
//
//  Created by Sameer Khavanekar on 1/16/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import Foundation
import Geth

open class EthTypeEncoder {
    open static let `default`: EthTypeEncoder = {
        return EthTypeEncoder()
    }()
    
    public class func isDynamic(_ parameter: Any) -> Bool {
        return parameter is String
    }
    
    func encode(_ parameter: Any) throws -> Data {
        
        print("Encoding to Big Int \(parameter as? GethBigInt)")
        
        if let result = parameter as? GethAddress {
            return _encode(result)
        }
        if let result = parameter as? GethBigInt {
            return _encode(result)
        }
        if let result = parameter as? String {
            return _encode(result)
        }
        print("Type can not be encoded \(parameter)")
        throw EthError.typeCanNotBeEncoded
    }
    
    func encode(_ parameter: Int) -> Data {
        let uintCount = UInt8(exactly: parameter) ?? 0
        let paramData = Data(bytes: [uintCount])
        let padding = EthType.MAX_BYTE_LENGTH - paramData.count
        let paddingBytes = Data(count: padding)
        
        var target = Data(capacity: EthType.MAX_BYTE_LENGTH)
        target.append(paddingBytes)
        target.append(contentsOf: paramData.bytes)
        return target
    }
    
    private func _encode(_ parameter: GethAddress) -> Data {
        var addressBytes = Data(count: 12)//gmtSendAddress!.getBytes()
        addressBytes.append(parameter.getBytes())
        return addressBytes
    }
    
    private func _encode(_ parameter: GethBigInt) -> Data {
        let valAmountData = parameter.getBytes()
        let totalCount = EthType.MAX_BYTE_LENGTH - valAmountData!.count
        var amountBytes = Data(count: totalCount)
        amountBytes.append(valAmountData!)
        return amountBytes
    }
    
    private func _encode(_ parameter: String) -> Data {
        let utf8Data = parameter.data(using: .utf8)!
        return _encodeDynamicBytes(utf8Data)
    }
    
    private func _encodeDynamicBytes(_ utf8Data: Data) -> Data {
        let count = utf8Data.count
        // Get Encoded Length
        var encodedLengthData = encode(count)
        let encodedBytesData = encodeBytes(data: utf8Data)
        encodedLengthData.append(contentsOf: encodedBytesData.bytes)
        return encodedLengthData
    }
    
    private func encodeBytes(data: Data) -> Data {
        let length = data.count
        let mod = length % EthType.MAX_BYTE_LENGTH
        
        if mod != 0 {
            let padding = EthType.MAX_BYTE_LENGTH - mod
            let paddingBytes = Data(count: padding)
            var target = Data(capacity: padding + length)
            target.append(contentsOf: data.bytes)
            target.append(paddingBytes)
            return target
        } else {
            return data
        }
    }


}
