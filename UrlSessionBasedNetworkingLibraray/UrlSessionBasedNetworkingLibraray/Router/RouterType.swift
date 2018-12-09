//
//  RouterType.swift
//  UrlSessionBasedNetworkingLibraray
//
//  Created by Ali Akhtar on 09/12/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation

public protocol RouterType {
    
    associatedtype Target: EndPointType
    func request(_ target: Target, completion: @escaping NetworkRouterCompletion)
}





