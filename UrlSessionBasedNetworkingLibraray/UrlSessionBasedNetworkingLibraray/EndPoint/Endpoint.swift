//
//  Endpoint.swift
//  UrlSessionBasedNetworkingLibraray
//
//  Created by Ali Akhtar on 09/12/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation

open class Endpoint {
    
    public let url: String
    public let method: HTTPMethod
    public let task: Task
    public let httpHeaderFields: [String: String]?
    
    public init(url: String,
                method: HTTPMethod,
                task: Task,
                httpHeaderFields: [String: String]?) {
        
        self.url = url
        self.method = method
        self.task = task
        self.httpHeaderFields = httpHeaderFields
    }
}


extension Endpoint {

    public func urlRequest() throws -> URLRequest {
        guard let requestURL = Foundation.URL(string: url) else {
            throw  CustomError.AAError.invalidURL(url: url)
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = httpHeaderFields
        
        switch task {
        case .requestPlain:
            return request
        case .requestParameters(parameters: let urlParameters):
            try? URLParameterEncoding.encode(urlRequest: &request, with: urlParameters)
            return request
        case .requestCompositeParameters(bodyParameters: let bodyParameters, urlParameters: let urlParameters):
            try? URLParameterEncoding.encode(urlRequest: &request, with: urlParameters)
            try? JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            return request
            
        case .uploadMultipart(let multipartForm):
            request.setValue(multipartForm.contentType, forHTTPHeaderField: "Content-Type")
            request.httpBody = multipartForm.body
            return request
            
        case .uploadCompositeMultipart(let multipartForm, urlParameters: let urlParameters):
            try? URLParameterEncoding.encode(urlRequest: &request, with: urlParameters)
            request.setValue(multipartForm.contentType, forHTTPHeaderField: "Content-Type")
            request.httpBody = multipartForm.body
            return request
        }
    }
}
