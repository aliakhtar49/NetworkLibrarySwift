//
//  AAManager.swift
//  UrlSessionBasedNetworkingLibraray
//
//  Created by Ali Akhtar on 18/11/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]
public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()
public typealias NetworkRouterDownloadCompletion = (_ url: URL?,_ response: URLResponse?,_ error: Error?)->()

class AAManager {
    
    public func upload(
        multipartFormData: @escaping (MultipartFormData) -> Void,
        to url: String,
        method: HTTPMethod = .post,
        headers: HTTPHeaders? = nil,
        compeletion: @escaping NetworkRouterCompletion)
    {
        return SessionManager.default.upload(
            multipartFormData: multipartFormData,
            to: url,
            method: method,
            headers: headers,
            completion: compeletion
        )
    }
    
    public func request(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping (NetworkRouterCompletion))
    {
        return SessionManager.default.request(
            url,
            method: method,
            parameters: parameters,
            headers: headers,
            completion: completion
        )
    }
    
    public func download(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping (NetworkRouterDownloadCompletion))
    {
        return SessionManager.default.download(
            url,
            method: method,
            parameters: parameters,
            headers: headers,
            completion: completion
        )
    }
    
    
    /*Method with only URLRequest prepopulated*/
    open func request(
        _ urlRequest: URLRequest,
        completion: @escaping (NetworkRouterCompletion))
    {
        return SessionManager.default.request(
            urlRequest,
            completion: completion
        )
    }
    open func upload(
        _ urlRequest: URLRequest,
        completion: @escaping (NetworkRouterCompletion))
    {
        return SessionManager.default.upload(
            urlRequest,
            completion: completion
        )
    }
    
    
}


