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

    func postPlace(params:Parameters, callback: @escaping (Error?) -> Void){
        
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.postPlace(parameters: params)) { (result: Result<PlacesResponse, Error>) in
            switch result {
            case .success(let data):
                let id = data.message
                for url in self.urls{
                    let params = ["place_id": id, "image_url": url]
                    self.postGallery(params: params, callback:{ error in
                        print(error?.localizedDescription)
                    })
                }
                callback(nil)
            case .failure(let error):
                callback(error)
            }
        }
    }
    
    
    
    func postGallery(params:Parameters, callback: @escaping (Error?) -> Void){
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.postImage(parameters: params)) { (result: Result<GalleryResponse, Error>) in
            switch result {
            case .success(let data):
                callback(nil)
            case .failure(let error):
                callback(error)
            }
        }
        
    }
    
    
    func uploadPhotoAPI(image: [Data?],callback: @escaping ([String]?,Error?) -> Void){
        
        NetworkingHelper.shared.uploadImage(route: MyAPIRouter.postUpload(image: image)) {  (result: Result<UploadResponse, Error>) in
            switch result {
            case .success(let data):
                self.urls = data.urls
                callback(data.urls,nil)
            case .failure(let error):
                callback(nil,error)
            }
        }
        
    }
    
    
}




