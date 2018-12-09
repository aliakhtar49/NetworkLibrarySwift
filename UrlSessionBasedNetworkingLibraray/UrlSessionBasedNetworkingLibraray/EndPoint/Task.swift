//
//  Task.swift
//  UrlSessionBasedNetworkingLibraray
//
//  Created by Ali Akhtar on 09/12/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation

public enum Task {
    
    /// A request with no additional data.
    case requestPlain
    
//    /// A requests body set with data.
//    case requestData(Data)
//    
//    /// A request body set with `Encodable` type
//    case requestJSONEncodable(Encodable)
//    
//    /// A request body set with `Encodable` type and custom encoder
//    case requestCustomJSONEncodable(Encodable, encoder: JSONEncoder)
//    
//    /// A requests body set with encoded parameters.
      case requestParameters(parameters: [String: String])
//    
//    /// A requests body set with data, combined with url parameters.
//    case requestCompositeData(bodyData: Data, urlParameters: [String: Any])
//    
//    /// A requests body set with encoded parameters combined with url parameters.
     case requestCompositeParameters(bodyParameters: [String: String], urlParameters: [String: String])
//    
//    /// A file upload task.
//    case uploadFile(URL)
//    
//    /// A "multipart/form-data" upload task.
    case uploadMultipart(MultipartFormData)
//    
//    /// A "multipart/form-data" upload task  combined with url parameters.
    case uploadCompositeMultipart(MultipartFormData, urlParameters: [String: String])
    
    /// A file download task to a destination.
   // case downloadDestination(DownloadDestination)
    
    /// A file download task to a destination with extra parameters using the given encoding.
   // case downloadParameters(parameters: [String: Any], encoding: ParameterEncoding, destination: DownloadDestination)
}
