//
//  AddNewPlaceViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//



import Foundation
import Alamofire
import UIKit

class AddNewPlaceViewModel {
    
    typealias closure = () -> Void
    
    //var urls: [String] = []
    var images: [UIImage] = []
    
    
    // createPlace -- createPlace
    // createGallery -- createGallery
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
}




