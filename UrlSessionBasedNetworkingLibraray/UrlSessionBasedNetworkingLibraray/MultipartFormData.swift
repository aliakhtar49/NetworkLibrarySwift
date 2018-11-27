//
//  MultipartFormData.swift
//  UrlSessionBasedNetworkingLibraray
//
//  Created by Ali Akhtar on 18/11/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation

open class MultipartFormData {
    
    public let boundary: String
    var body : Data
    let lineBreak = "\r\n"
    
    open lazy var contentType: String = "multipart/form-data; boundary=\(self.boundary)"
    init() {
        self.boundary = MultipartFormData.generateBoundary()
        body = Data()
    }
    public func append(with key: String, and value: String){
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
        body.append("\(value + lineBreak)")
    }
    public func append(_ data: Data, withName name: String, fileName: String, mimeType: String) {
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\(lineBreak)")
        body.append("Content-Type: \(mimeType + lineBreak + lineBreak)")
        body.append(data)
        body.append(lineBreak)
    }
    public func finalizebody() {
        body.append("--\(boundary)--\(lineBreak)")
    }
    
    static func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}
