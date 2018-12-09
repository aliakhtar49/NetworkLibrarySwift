//
//  MyImageService.swift
//  UrlSessionBasedNetworkingLibraray
//
//  Created by Ali Akhtar on 09/12/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation

enum MyImageService{
    case uploadGif(Data, description: Dictionary<String, Any>)
}

extension MyImageService: EndPointType{
    var baseURL: URL {
        return URL(string: "https://api.imgur.com")!
    }
    
    var path: String {
        switch self {
        case .uploadGif:
            return "/3/image"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .uploadGif:
            return .post
        }
    }
    
    
    var task: Task {
        switch self {
            //with url parameter in body
        case let .uploadGif(imageData, urlParameters):
            let multipartFormData = MultipartFormData()
            for(key,value) in urlParameters {
                multipartFormData.append(with: key, and: value as! String)
            }

            multipartFormData.append(imageData, withName: "image", fileName:"image.png", mimeType:"image/png")
            multipartFormData.finalizebody()
            return .uploadMultipart(multipartFormData)
            
            //parameter in url
//        case let .uploadGif(imageData, urlParameters):
//            let multipartFormData = MultipartFormData()
//            multipartFormData.append(imageData, withName: "image", fileName:"image.png", mimeType:"image/png")
//            multipartFormData.finalizebody()
//            return .uploadCompositeMultipart(multipartFormData, urlParameters: urlParameters as! [String : String])
            }
    }
    
    var headers: [String : String]? {
        return [
            "Content-type" : "multipart/form-data",
            "Authorization" :"Client-ID 069a85e0658cde5"
        ]
    }
    
    
}
