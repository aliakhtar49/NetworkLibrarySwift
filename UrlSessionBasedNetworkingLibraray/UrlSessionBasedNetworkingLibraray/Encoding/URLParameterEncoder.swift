//
//  URLParameterEncoder.swift
//  NetworkLibraray
//
//  Created by Ali Akhtar on 04/11/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters?) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
                if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                    urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
                }
        
        guard let parameters = parameters else { return }
        
        if let method = HTTPMethod(rawValue: urlRequest.httpMethod ?? "GET"), encodesParametersInURL(with: method) {
    
            
                if var urlComponenets = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                                urlComponenets.queryItems = [URLQueryItem]()
                    
                                for(key,value) in parameters {
                                    let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                                    urlComponenets.queryItems?.append(queryItem)
                                }
                                urlRequest.url = urlComponenets.url
                            }
            
        } else {
            do {
                let jsonData  = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                urlRequest.httpBody = jsonData
                if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
            }catch {
                throw NetworkError.encodingFailed
            }
        }
        
       
//        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
//            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        }
//
//        guard let parameters = parameters else { return }
//
//        if var urlComponenets = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
//            urlComponenets.queryItems = [URLQueryItem]()
//
//            for(key,value) in parameters {
//                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
//                urlComponenets.queryItems?.append(queryItem)
//            }
//            urlRequest.url = urlComponenets.url
//        }
        
       
    }
    private static func encodesParametersInURL(with method: HTTPMethod) -> Bool {
        switch method {
        case .get:
            return true
        default:
            return false
        }
    }
}
