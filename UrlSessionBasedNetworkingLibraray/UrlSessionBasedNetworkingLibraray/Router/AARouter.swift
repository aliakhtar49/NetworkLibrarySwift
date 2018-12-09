//
//  AARouter.swift
//  UrlSessionBasedNetworkingLibraray
//
//  Created by Ali Akhtar on 09/12/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation


open class AARouter<Target: EndPointType>: RouterType {
    
    public typealias EndpointClosure = (Target) -> Endpoint
    public let endpointClosure: EndpointClosure

    public init(endpointClosure: @escaping EndpointClosure = AARouter.defaultEndpointMapping) {
        self.endpointClosure = endpointClosure
    }
  
    /// Returns an `Endpoint` based on the token, method, and parameters by invoking the `endpointClosure`.
    open func endpoint(_ token: Target) -> Endpoint {
        return endpointClosure(token)
    }
    
    
    open func request(_ target: Target,
                      completion: @escaping NetworkRouterCompletion) {
        
        buildRequest(target, completion: completion)
    }
}


public extension AARouter {
    
    func buildRequest(_ target: Target, completion: @escaping NetworkRouterCompletion) {
        let endpoint = self.endpoint(target)
        do {
            let urlRequest = try endpoint.urlRequest()
            
            switch endpoint.task {
            case .requestPlain,.requestParameters,.requestCompositeParameters:
                AAManager.init().request(urlRequest, completion: completion)
                
            case .uploadMultipart,.uploadCompositeMultipart:
                AAManager.init().upload(urlRequest, completion: completion)
            }
        }catch {
            
        }
    }
}
public extension AARouter {
    
    public final class func defaultEndpointMapping(for target: Target) -> Endpoint {
        return Endpoint(
            url: URL(target: target).absoluteString,
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
}
