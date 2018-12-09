//
//  ParameterEncoding.swift
//  NetworkLibraray
//
//  Created by Ali Akhtar on 04/11/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation

public typealias Parameters = [String:String]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters?) throws
}




