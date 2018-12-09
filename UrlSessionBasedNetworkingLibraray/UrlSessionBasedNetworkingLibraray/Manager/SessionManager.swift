//
//  SessionManager.swift
//  UrlSessionBasedNetworkingLibraray
//
//  Created by Ali Akhtar on 18/11/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation


open class SessionManager: NSObject {
    
    public let session: URLSession
    
    public static let `default`: SessionManager = {
        let configuration = URLSessionConfiguration.default
        
        return SessionManager(configuration: configuration)
    }()
    
    
    public init(
        configuration: URLSessionConfiguration = URLSessionConfiguration.default)
    {
        self.session = URLSession(configuration: configuration)
    }
    
    
    /* Upload any File */
    open func upload(
        multipartFormData: @escaping (MultipartFormData) -> Void,
        to url: String,
        method: HTTPMethod = .post,
        headers: HTTPHeaders? = nil,
        completion: @escaping (NetworkRouterCompletion))
    {
        do {
            var request  = try URLRequest(url: url, method: method, headers: headers)
            let formData = MultipartFormData()
            multipartFormData(formData)
            request.setValue(formData.contentType, forHTTPHeaderField: "Content-Type")
            session.uploadTask(with: request, from: formData.body) { (data, response, error) in
                completion(data,response,error)
                }.resume()
        }catch {
            return
        }
    }
    
    
    

    open func request(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping (NetworkRouterCompletion))
    {
        var originalRequest: URLRequest
        
        do {
            originalRequest = try URLRequest(url: url, method: method, headers: headers)
            try URLParameterEncoder.encode(urlRequest: &originalRequest, with: parameters)
            session.dataTask(with: originalRequest) { (data, response, error) in
                completion(data,response,error)
            }.resume()
        } catch {
         
        }
    }
    
    open func request(
        _ urlRequest: URLRequest,
        completion: @escaping (NetworkRouterCompletion))
    {
            session.dataTask(with: urlRequest) { (data, response, error) in
                completion(data,response,error)
                }.resume()
    }
    
    open func upload(
        _ urlRequest: URLRequest,
        completion: @escaping (NetworkRouterCompletion))
    {
            session.uploadTask(with: urlRequest, from: urlRequest.httpBody) { (data, response, error) in
                completion(data,response,error)
                }.resume()
    }

    open func download(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping (NetworkRouterDownloadCompletion))
    {
        var originalRequest: URLRequest
        do {
            originalRequest = try URLRequest(url: url, method: method, headers: headers)
            try URLParameterEncoder.encode(urlRequest: &originalRequest, with: parameters)
            session.downloadTask(with: originalRequest) { (url, response, error) in
                
                completion(url, response,error)

            }.resume()
        } catch {
            
        }
    }
    
}

//extension SessionManager: URLSessionDownloadDelegate,URLSessionTaskDelegate {
//    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError Inf: Error?) {
//        
//    }
//    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
//                    didFinishDownloadingTo location: URL) {
//        // 1
//        guard let sourceURL = downloadTask.originalRequest?.url else { return }
//        // 2
//        let destinationURL = localFilePath(for: sourceURL)
//        print(destinationURL)
//        // 3
//        let fileManager = FileManager.default
//        try? fileManager.removeItem(at: destinationURL)
//        do {
//            try fileManager.copyItem(at: location, to: destinationURL)
//        } catch let error {
//            print("Could not copy file to disk: \(error.localizedDescription)")
//        }
//        // 4
//        //        if let index = download?.track.index {
//        //            DispatchQueue.main.async {
//        //                self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
//        //            }
//        //        }
//        
//    }
//}
