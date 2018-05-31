//
//  EthType.swift
//  Dust
//
//  Created by Sameer Khavanekar on 1/15/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import Foundation

public struct EthType {
    public static let MAX_BIT_LENGTH: Int = 256
    public static var MAX_BYTE_LENGTH: Int {
        return MAX_BIT_LENGTH / 8
    }
}

