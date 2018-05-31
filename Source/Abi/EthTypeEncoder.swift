//
//  EthTypeEncoder.swift
//  Dust
//
//  Created by Sameer Khavanekar on 1/16/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import Foundation
import Geth


public protocol EthEncodable {
    func ethEncode() -> Data
    func typeString() -> String
}

extension EthEncodable {
    public func typeString() -> String {
        let typeOfParam = "\(type(of: self))"
        return typeOfParam.lowercased()
    }
}

extension Int : EthEncodable {
    public func ethEncode() -> Data {
        let uintCount = UInt8(exactly: self) ?? 0
        let paramData = Data(bytes: [uintCount])
        let padding = EthType.MAX_BYTE_LENGTH - paramData.count
        let paddingBytes = Data(count: padding)
        
        var target = Data(capacity: EthType.MAX_BYTE_LENGTH)
        target.append(paddingBytes)
        target.append(contentsOf: paramData.bytes)
        return target
    }
}

extension String : EthEncodable {
    public func ethEncode() -> Data {
        let utf8Data = self.data(using: .utf8)!
        return _encodeDynamicBytes(utf8Data)
    }
    
    private func _encodeDynamicBytes(_ utf8Data: Data) -> Data {
        let count = utf8Data.count
        // Get Encoded Length
        var encodedLengthData = count.ethEncode()
        let encodedBytesData = utf8Data.ethEncode()
        encodedLengthData.append(contentsOf: encodedBytesData.bytes)
        return encodedLengthData
    }
}

extension Data : EthEncodable {
    public func ethEncode() -> Data {
        let length = self.count
        let mod = length % EthType.MAX_BYTE_LENGTH
        
        if mod != 0 {
            let padding = EthType.MAX_BYTE_LENGTH - mod
            let paddingBytes = Data(count: padding)
            var target = Data(capacity: padding + length)
            target.append(contentsOf: self.bytes)
            target.append(paddingBytes)
            return target
        } else {
            return self
        }
    }
}

extension GethBigInt : EthEncodable {
    public func ethEncode() -> Data {
        let valAmountData = self.getBytes()
        let totalCount = EthType.MAX_BYTE_LENGTH - (valAmountData?.count ?? 0)
        var amountBytes = Data(count: totalCount)
        
        if let valAmountData = valAmountData {
            amountBytes.append(valAmountData)
        }
        return amountBytes
    }
    
    public func typeString() -> String {
        return "uint256"
    }
}

extension GethAddress : EthEncodable {
    public func ethEncode() -> Data {
        var addressBytes = Data(count: 12)//gmtSendAddress!.getBytes()
        addressBytes.append(self.getBytes())
        return addressBytes
    }
    
    public func typeString() -> String {
        return "address"
    }
}

extension Array where Element == EthEncodable {
    public func ethEncode() -> Data {
        var result = Data()
        let dynamicDataOffset: Int = _getLength(self) * EthType.MAX_BYTE_LENGTH
        
        for parameter in self {
            let encodedValue = parameter.ethEncode()
            
            if parameter is String {
                let encodedDataOffset = dynamicDataOffset.ethEncode()
                print("Encoded Offset \(encodedDataOffset.bytes)")
                print("Encoded Offset hex \(encodedDataOffset.bytes.toHexString())")
                result.append(encodedDataOffset)
                let encodedParameter = parameter.ethEncode()
                result.append(encodedParameter)
            } else {
                result.append(encodedValue)
            }
        }
        
        return result
    }
    
    private func _getLength(_ parameters: Array<EthEncodable>) -> Int {
        var count = 0
        for parameter in parameters {
            if let parameter = parameter as? Array<EthEncodable> {
                count += parameter.count // TODO: - We need to look at this
            } else {
                count += 1
            }
        }
        return count
    }
}
