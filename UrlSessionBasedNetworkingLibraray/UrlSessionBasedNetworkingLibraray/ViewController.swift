//
//  ViewController.swift
//  UrlSessionBasedNetworkingLibraray
//
//  Created by Ali Akhtar on 17/11/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import UIKit


class ViewController: UIViewController, URLSessionDownloadDelegate,URLSessionTaskDelegate{
    @IBOutlet weak var imageViiew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
//      //  let previewURL = URL(string: "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/Music3/v4/b8/b3/7a/b8b37a93-2154-34da-74fc-8e8a316979a8/mzaf_7991652075174454658.plus.aac.p.m4a"),
//        let url = URL(string: "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/Music3/v4/b8/b3/7a/b8b37a93-2154-34da-74fc-8e8a316979a8/mzaf_7991652075174454658.plus.aac.p.m4a")
//        let task = session.downloadTask(with: url!)
//        //let task = sessios.downloadTask(with:"https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/Music/v4/63/77/58/637758d5-3c2d-83ed-62ec-8174a5621d9f/mzaf_5221241716578490363.plus.aac.p.m4a")
//        task.resume()
        
        
//        AAManager.init().download("https://i.imgur.com/qPRsKeZ.jpg") { (data, response, error) in
//
//        }
      //   guard let sourceURL = downloadTask.originalRequest?.url else { return }
      
        
//        AAManager.init().request("http://localhost:3000/users", method: .post, parameters: ["name": "Ali","location":"LA"]) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//            if let data = data {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
//                }catch {
//                    print(error)
//                }
//            }
//        }
        
        //getPostRequest() //using multi-part image download
        //getRequestUsingAAManager()
//        Alamofire.request(.GET, "https://robohash.org/123.png").response { (request, response, data, error) in
//            self.myImageView.image = UIImage(data: data, scale:1)
//        }
        
        
        
        
        
        
        /*GET Image */
//        AAManager.init().request("https://i.imgur.com/qPRsKeZ.jpg") { (data, response, error) in
//            DispatchQueue.main.sync {
//                self.imageViiew.image = UIImage(data: data!, scale:1)
//            }
        
            

       // }
     
    }

  
    func getDownloadExampleWithCompeletionBlock() {
        let sourceURL = URL(string: "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/Music/v4/63/77/58/637758d5-3c2d-83ed-62ec-8174a5621d9f/mzaf_5221241716578490363.plus.aac.p.m4a")
        AAManager.init().download("https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/Music/v4/63/77/58/637758d5-3c2d-83ed-62ec-8174a5621d9f/mzaf_5221241716578490363.plus.aac.p.m4a") { [weak self] (url, reponse, error) in
            // 1
            
            guard let strongSelf = self else  { return }
            guard let sourceURL = sourceURL else { return }
            
            let destinationURL = strongSelf.localFilePath(for: sourceURL)
            print(destinationURL)
            // 3
            let fileManager = FileManager.default
            try? fileManager.removeItem(at: destinationURL)
            do {
                try fileManager.copyItem(at: url!, to: destinationURL)
                
            } catch let error {
                print("Could not copy file to disk: \(error.localizedDescription)")
            }
        }
    }
    func getRequestUsingAAManager() {
        
        AAManager.init().request("https://itunes.apple.com/search/media=music&entity=song&term=swift") { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch {
                    print(error)
                }
            }
        }
    }
    
    func getPostRequest(){
        
        let imageData = UIImageJPEGRepresentation(#imageLiteral(resourceName: "imageOne.png"), 0.7)
        let url = "https://api.imgur.com/3/image"
        let parameters = ["name":"MyTestFile2322","description":"My tutorial ali"]
        let headers: HTTPHeaders = [
           "Content-type" : "multipart/form-data",
            "Authorization" :"Client-ID 069a85e0658cde5"
        ]
        AAManager.init().upload(multipartFormData: { (multipartFormData) in
            for(key,value) in parameters {
                multipartFormData.append(with: key, and: value)
            }
            if let data = imageData{
                multipartFormData.append(data, withName: "image", fileName:"image.png", mimeType:"image/png")
            }
            multipartFormData.finalizebody()
        }, to: url, method: .post, headers: headers) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch {
                    print(error)
                }
            }
        }
    }
    
    
    
    
    
   
    func getPostRequestHardcoded(){
        
        let imageData = UIImageJPEGRepresentation(#imageLiteral(resourceName: "imageOne.png"), 0.7)
        let url = "https://api.imgur.com/3/image" /* your API url */
        let parameters = ["name":"MyTestFile2322","description":"My tutorial ali"]
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type" : "multipart/form-data",
            "Authorization" :"Client-ID 069a85e0658cde5"
        ]
        AAManager.init().upload(multipartFormData: { (multipartFormData) in
            for(key,value) in parameters {
                multipartFormData.append(with: key, and: value)
            }
            if let data = imageData{
                multipartFormData.append(data, withName: "image", fileName:"image.png", mimeType:"image/png")
            }

            
        }, to: url, method: .post, headers: headers) { (data, response, error) in
            
            
            
            if let response = response {
                                                print(response)
                                            }
                                            if let data = data {
                                                do {
                                                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                                                    print(json)
                                                }catch {
                                                    print(error)
                                                }
                                            }
        }
//        AAManager.init().upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//
//            if let data = imageData{
//                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
//            }
//
//        }, to: url, method: .post, headers: headers) { (result) in
//            switch result{
//            case .success(let upload, _, _):
//                upload.responseJSON { response in
//                    print("Succesfully uploaded")
//                    if let err = response.error{
//                        print(err.localizedDescription)
//                    }
//                    else {
//                        print(response)
//                    }
//
//                }
//            case .failure(let error):
//                print("Error in upload: \(error.localizedDescription)")
//
//            }
//        }
        
        
//        let boundary = generateBoundary()
//        let parameters = ["name":"MyTestFile2322","description":"My tutorial ali"]
//        guard let mediaImage = Media(withImage: #imageLiteral(resourceName: "imageOne.png"), forKey: "image") else { return }
//
//        guard let url = URL(string: "https://api.imgur.com/3/image") else { return }
//        var request  = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//           request.addValue("Client-ID 069a85e0658cde5", forHTTPHeaderField: "Authorization")
//        let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary:boundary)
//
//        request.httpBody = dataBody
//
//        let session  = URLSession.shared
//        session.uploadTask(with: request, from: dataBody) { (data, response, error) in
//            if let response = response {
//                                print(response)
//                            }
//                            if let data = data {
//                                do {
//                                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                                    print(json)
//                                }catch {
//                                    print(error)
//                                }
//                            }
//        }.resume()
//        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//            if let data = data {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
//                }catch {
//                    print(error)
//                }
//            }
//            }.resume()
        
    }
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func localFilePath(for url: URL) -> URL {
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError Inf: Error?) {
        
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        // 1
        guard let sourceURL = downloadTask.originalRequest?.url else { return }
        // 2
        let destinationURL = localFilePath(for: sourceURL)
        print(destinationURL)
        // 3
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: destinationURL)
        do {
            try fileManager.copyItem(at: location, to: destinationURL)
        } catch let error {
            print("Could not copy file to disk: \(error.localizedDescription)")
        }
        // 4
//        if let index = download?.track.index {
//            DispatchQueue.main.async {
//                self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
//            }
//        }
        
    }
    func getRequest(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        var request  = URLRequest(url: url)
       request.setValue("multipart/form-data; boundary=\(generateBoundary())", forHTTPHeaderField: "Content-Type")
     
        let dataBody = createDataBody(withParameters: nil, media: nil, boundary: generateBoundary())
        
        request.httpBody = dataBody
        
        let session  = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch {
                    print(error)
                }
            }
        }.resume()
        
    }
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    func createDataBody(withParameters params: Parameters?,media: [Media]?,boundary: String) -> Data {
        //\r for linux windows \n
        let lineBreak = "\r\n"
           var body = Data()
        if let paramaters  = params {
            for (key,value) in paramaters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            
            }
        }
        
        if let media  = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
     
        return body
    }

}
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8){
            append(data)
        }
    }
}
struct Media {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: String
    
    init?(withImage image:UIImage,forKey key:String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.fileName = "photo\(arc4random()).jpeg"
        guard let data = UIImageJPEGRepresentation(image, 0.7) else { return nil }
        self.data = data
    }
}

