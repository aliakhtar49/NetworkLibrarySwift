//
//  MyService.swift
//  UrlSessionBasedNetworkingLibraray
//
//  Created by Ali Akhtar on 09/12/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation

enum MyService {
    case showTopics
    case createUser(firstName: String, lastName: String)
    case showTopicsWith(one: String, two: String)
    case createTopics(id: String, name: String, description: String)
}
extension MyService: EndPointType {
    var baseURL: URL {
        return URL(string: "http://localhost:8080")!
    }
    
    var path: String {
        switch self {
        case .showTopics, .showTopicsWith,.createTopics:
            return "/topics"
        case .createUser(_, _):
            return "/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .showTopics ,.showTopicsWith:
            return .get
            
            
        case .createUser,.createTopics:
            return .post
        }
    }
    
    
    var task: Task {
        switch self {
        case .showTopics: // Send no parameters
            return .requestPlain
            
        case .showTopicsWith(let first , let second):
            return .requestParameters(parameters: [first : first,second:second])
            
        case .createUser(let firstName, let lastName): // Always send parameters as JSON in request body
            return .requestPlain
            
        case .createTopics(let id, let name , let description):
            return .requestCompositeParameters(bodyParameters: ["id":id,"name":name,"description":description], urlParameters: ["one": "one","two":"two"])
        }
        
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
