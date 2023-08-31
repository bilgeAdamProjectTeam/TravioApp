//
//  AddNewPlaceViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//



import Foundation
import Alamofire
import UIKit
import MapKit

class AddNewPlaceViewModel {

    var urls: [String]?
    var image: [UIImage]?

    
    func postPlace(input: PlaceInfo, callback: @escaping () -> Void){
        
        let params = ["place":input.place, "title": input.title, "description":input.description, "cover_image_url":input.cover_image_url, "latitude":input.latitude, "longitude":input.longitude] as [String : Any]
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.postPlace(parameters: params)){ (result: Result<PlacesResponse, Error>) in
            switch result {
            case .success:
                callback()
            case .failure(let error):
                print("Hata:", error.localizedDescription)
            }
        }
    }
    
    
    
    func postGallery(input:GalleryInfo, callback: @escaping() -> Void){
        
        let params = ["place_id": input.place_id, "image_url": input.image_url]
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.postImage(parameters: params)) { (result: Result<GalleryResponse, Error>) in
            switch result {
            case .success:
                callback()
            case .failure(let error):
                print("Hata:", error.localizedDescription)
            }
        }
        
    }
    
    
    func uploadPhotoAPI(callback: @escaping () -> Void){
        
        print("x")
        
    }
    
    
    //PostPlace parameters
    //{
    //      "place": "Nevşehir, Türkiye",
    //      "title": "Kapadokya",
    //      "description": "Kapadokya, adeta peri masallarının gerçeğe dönüştüğü büyülü bir dünyadır.",
    //      "cover_image_url": "https://iosclass.ams3.digitaloceanspaces.com/1692817007606598873.png",
    //      "latitude": 38.6431,
    //      "longitude": 34.8287
    //}
    
    
    
    
    
//    func postUpload(imageData: Data, callback: @escaping (UploadResponse) -> Void){
//        NetworkingHelper.shared. objectRequestRouter(request: MyAPIRouter.postUpload(imageData: imageData)) {(result: Result<UploadResponse, Error>) in
//            switch result {
//            case .success(let response):
//                if let urls = response["urls"]?.first {
//                    .success(urls)
//                } else {
//                    .failure(Error.invalidResponse)
//                }
//            case .failure(let error):
//                .failure(error)
//            }
//        }
//    }
//
//

    
}




