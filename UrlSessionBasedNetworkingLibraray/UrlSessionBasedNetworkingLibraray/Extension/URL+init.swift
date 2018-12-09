//
//  URL+init.swift
//  UrlSessionBasedNetworkingLibraray
//
//  Created by Ali Akhtar on 09/12/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation

public extension URL {
    
    /// Initialize URL from Moya's `TargetType`.
    init<T: EndPointType>(target: T) {
        
        if target.path.isEmpty {
            self = target.baseURL
        } else {
            self = target.baseURL.appendingPathComponent(target.path)
        }
    }
}
