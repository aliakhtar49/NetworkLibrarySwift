//
//  NetworkError.swift
//  NetworkLibraray
//
//  Created by Ali Akhtar on 04/11/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation


public enum NetworkError : String , Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameter encoding failed"
    case missingURL = "URL is nil"
}


