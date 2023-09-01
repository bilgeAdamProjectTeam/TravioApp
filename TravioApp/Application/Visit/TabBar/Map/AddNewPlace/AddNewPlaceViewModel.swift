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

    var urls: [String] = []
    var image: [UIImage] = []

//    input: PlaceInfo
    func postPlace(params:Parameters, callback: @escaping () -> Void){
        
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.postPlace(parameters: params)) { (result: Result<PlacesResponse, Error>) in
            switch result {
            case .success(let data):
                let id = data.message
                for url in self.urls{
                    let params = ["place_id": id, "image_url": url]
                    self.postGallery(params: params)
                }
                callback()
            case .failure(let error):
                print("Hata:", error.localizedDescription)
            }
        }
    }
    
    
    
    func postGallery(params:Parameters){
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.postImage(parameters: params)) { (result: Result<GalleryResponse, Error>) in
            switch result {
            case .success(let data):
                print("Create Gallery: \(data)")
            case .failure(let error):
                print("Hata:", error.localizedDescription)
            }
        }
        
    }
    
    
    func uploadPhotoAPI(image: [Data?],callback: @escaping ([String]) -> Void){
        
        NetworkingHelper.shared.uploadImage(route: MyAPIRouter.postUpload(image: image)) {  (result: Result<UploadResponse, Error>) in
            switch result {
            case .success(let data):
                self.urls = data.urls
                callback(data.urls)
            case .failure(let error):
                print("Hata:", error.localizedDescription)
                print(self.urls)
            }
        }
        
    }

    
}




