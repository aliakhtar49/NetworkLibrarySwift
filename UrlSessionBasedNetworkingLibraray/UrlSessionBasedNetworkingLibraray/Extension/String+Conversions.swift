//
//  String+Conversions.swift
//  UrlSessionBasedNetworkingLibraray
//
//  Created by Ali Akhtar on 18/11/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation

extension String {
    
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw CustomError.AAError.invalidURL(url: self) }
        return url
    }
}
