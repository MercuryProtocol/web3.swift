//
//  String+Extension.swift
//  web3swift
//
//  Created by Sameer Khavanekar on 1/23/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import Foundation
import CryptoSwift

public extension String {
    
    //Checks if the given string is an address in hexidecimal encoded form.
    public func isHexAddress() -> Bool {
        if !Set([40, 42]).contains(self.count) {
            return false
        } else if isHex() {
            return true
        }
        return false
    }

    public func isHex() -> Bool {
        let lowerCasedSample = self.lowercased()
        if lowerCasedSample.contains("0x") {
            return true
        }
        let unprefixedValue = lowerCasedSample.remove0xPrefix()
        let hexRegex = "^[0-9a-f]+$"
        let regex = try! NSRegularExpression(pattern: hexRegex, options: [])
        let matches = regex.matches(in: unprefixedValue, options: [], range: NSRange(location: 0, length: unprefixedValue.count))
        
        if matches.count > 0 {
            return true
        }
        return false
    }

    public func is0xPrefixed() -> Bool {
        return self.hasPrefix("0x") || self.hasPrefix("0X")
    }
    
    public func remove0xPrefix() -> String {
        if is0xPrefixed() {
            let index2 = self.index(self.startIndex, offsetBy: 2)
            return String(self[index2...])
        }
        return self
    }
    
    public func toDecimalPlaces(_ value: Int) -> String {
        let charset: Character = "."
        if let index = self.index(of: charset) {
            let distanceToDecimal = self.distance(from: self.startIndex, to: index).advanced(by: value + 1)
            if let lastIndex = self.index(self.startIndex, offsetBy: distanceToDecimal, limitedBy: self.endIndex) {
                return String(self[..<lastIndex])
            } else {
                return self
            }
        }
        return self
    }
    
    var wholeValue: String {
        if let decimalIndex = self.index(of: ".") {
            return String(self[..<decimalIndex])
        } else {
            return self
        }
    }
    
    public func trimmingFirstConsecutiveCharacters(_ character: String) -> String? {
        let pattern = "^\(character)+(?!$)"
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let match = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count))
            
            if let match = match {
                let startIndex = String.Index(encodedOffset: match.range.length)
                let endIndex = String.Index(encodedOffset: self.count)
                let result = self[startIndex..<endIndex]
                return String(result)
            } else {
                return self
            }
        } catch {
            print("Failed to create regex pattern for given character")
            return nil
        }
    }
    
}
