//
//  JSONParameterEncoder.swift
//  NetworkLibraray
//
//  Created by Ali Akhtar on 04/11/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters?) throws {
        do {
            let jsonData  = try JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
         }catch {
            throw NetworkError.encodingFailed
        }
    }
}
