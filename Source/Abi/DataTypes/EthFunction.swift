//
//  EthFunction.swift
//  Dust
//
//  Created by Sameer Khavanekar on 1/15/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import Foundation

open class EthFunction {
    private var _name: String!
    private var _inputParameters: Array<EthEncodable>!
    private var _outputParameters: Array<EthEncodable>?
    
    public init(name: String, inputParameters: Array<EthEncodable>, outputParameters: Array<EthEncodable>? = nil) {
        _name = name
        _inputParameters = inputParameters
        _outputParameters = outputParameters
    }
    
    public func getName() -> String {
        return _name
    }
    
    public func getInputParameters() -> Array<EthEncodable> {
        return _inputParameters
    }
    
    public func getOutputParameters() -> Array<EthEncodable>? {
        return _outputParameters
    }
    
}
