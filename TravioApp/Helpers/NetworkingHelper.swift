//
//  NetworkHelper.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 28.08.2023.
//

import Foundation
import Alamofire

class NetworkingHelper {
    
    static let shared = NetworkingHelper()
    
    func objectRequestRouter<T:Codable>(request: URLRequestConvertible, callback: @escaping (Result<T,Error>) -> Void) {
        
        AF.request(request).responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value)
                    let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
                    callback(.success(decodedData))
                } catch {
                    callback(.failure(error))
                }
            case .failure(let err):
                callback(.failure(err))
            }
        }
        
    }
    
    
    func uploadImage<T: Codable>(route: MyAPIRouter, callback: @escaping (Result<T,Error>) -> Void){
        
        
        let request: URLRequestConvertible = route

        AF.upload(multipartFormData: route.multipartFormData , with: request).validate()
            .responseData {response in
                switch response.result {
                case .success(let data):
                    do {
        
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        callback(.success(decodedData))
                    } catch {
                        callback(.failure(error))
                    }
                case .failure(let err):
                    callback(.failure(err))
                }
            }
    }
    
    
    
}


//
//  AddVisitVM.swift
//  TravioApplication
//

//

//import Foundation
//import Alamofire
//import UIKit
//
//class AddVisitVM {
//
//    typealias closure = () -> Void
//
//    var urls: [String] = []
//    var images: [UIImage] = []
//
//    func createPlace(parameters: Parameters, complate: closure) {
//        NetworkHelper.shared.routerRequest(request: Router.createPlace(parameters: parameters)) { (result: Result<Response, Error>) in
//            switch result {
//            case .success(let data):
//                print("Urls-----------:\(self.urls)")
//                let id = data.message
//
//                for image in self.images {
////                    uploadPhotoToAPI(image: image)
//                }
//
//                for url in self.urls {
//                    self.createGallery(place_id: id, url: url) {
//                        print("galleryİşlemi bitti")
//                    }
//                }
//            case .failure(let error):
//                print("Error")
//            }
//        }
//    }
//
//    func createGallery(place_id: String, url: String, complate: closure) {
//        NetworkHelper.shared.routerRequest(request: Router.createGallery(parameters: ["place_id": place_id, "image_url": url])) { (result: Result<Response, Error>) in
//            switch result {
//            case .success(let data):
//                print("Create Gallery: \(data)")
//            case .failure(let error):
//                print("Create Gallery Error: \(error.localizedDescription)")
//            }
//        }
//    }
//
//    func uploadPhotoToAPI() {
//        let uploadURL = "https://api.iosclass.live/upload"
//
//        for image in images {
//            AF.upload(
//                multipartFormData: { multipartFormData in
//                    if let imageData = self.image.jpegData(compressionQuality: 0.8) {
//                        multipartFormData.append(imageData, withName: "file", fileName: "file.jpg", mimeType: "file/jpeg")
//                        // Gerekirse, diğer multipart form data alanlarını da ekleyebilirsiniz
//                    }
//                },
//                to: uploadURL,
//                method: .post
//            )
//            .responseJSON { response in
//                if let data = response.data {
//                    do {
//                        let decoder = JSONDecoder()
//                        let responseModel = try decoder.decode(UploadResponse.self, from: data)
//                        let urls = responseModel.urls
//                        for url in urls {
//                            print("URL:", url)
//                            self.urls.append(url)
//                        }
//                    } catch let error {
//                        print("Decoding Error:", error)
//                    }
//                }
//            }
//        }
//    }
//}
