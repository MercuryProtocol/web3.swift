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
    private var _inputParameters: Array<Any>!
    private var _outputParameters: Array<Any>?
    
    public init(name: String, inputParameters: Array<Any>, outputParameters: Array<Any>? = nil) {
        _name = name
        _inputParameters = inputParameters
        _outputParameters = outputParameters
    }
    
    public func getName() -> String {
        return _name
    }
    
    public func getInputParameters() -> Array<Any> {
        return _inputParameters
    }
    
    public func getOutputParameters() -> Array<Any>? {
        return _outputParameters
    }
    
}
