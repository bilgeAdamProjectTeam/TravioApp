//
//  VisitsViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import Foundation
import Alamofire

class VisitsViewModel {
    
    var visits: VisitResponse?
    var placeId: String?
    var images: ImageResponse?
    var isLoading: Bool?
    var isLoadingDidChange: ((Bool) -> Void)?
    var places: Place?
    
    
    func getVisits(callback: @escaping (VisitResponse?,Error?) -> Void){
        
        let params = ["page":1,"limit":50]
        
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.getVisits(parameters: params), callback: { (result: Result<VisitResponse, Error>) in
            switch result {
            case .success(let visits):
                self.visits = visits
                callback(visits,nil)
            case .failure(let error):
                callback(nil,error)
            }
        })
    }
    
    
    func getVisitImage(placeId:String, callback: @escaping (ImageResponse?,Error?) -> Void) {
        
        isLoadingDidChange?(true)
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.getAllImagesbyPlaceID(placeId: placeId), callback: {(result: Result<ImageResponse, Error>) in
            switch result {
            case .success(let images):
                self.images = images
                self.isLoadingDidChange?(false)
                callback(images,nil)
            case .failure(let error):
                callback(nil,error)
            }
        })
    }
    
    func getPlaceById(placeId:String, callback: @escaping(PlaceResponseNew?,Error?) -> Void){
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.getPlaceByID(placeId: placeId), callback:{(result: Result<PlaceResponseNew, Error>) in
            switch result {
            case .success(let data):
                callback(data,nil)
            case .failure(let error):
                callback(nil,error)
            }
        })
    }
    
    func postVisit(parameters: Parameters, callback: @escaping(VisitPostResponse?,Error?) -> Void){
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.postVisit(parameters: parameters), callback:{(result: Result<VisitPostResponse, Error>) in
            switch result {
            case .success(let data):
                callback(data,nil)
            case .failure(let error):
               callback(nil,error)
            }
            
        })
    }
    
    func deleteVisit(placeId:String, callback: @escaping(VisitPostResponse?,Error?) -> Void){
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.deleteVisitByID(placeId: placeId), callback:{(result: Result<VisitPostResponse, Error>) in
            switch result {
            case .success(let data):
                callback(data,nil)
            case .failure(let error):
                callback(nil,error)
            }
        })
        
    }
    
    
    func checkVisitByID(placeId: String, callback: @escaping(VisitPostResponse?,Error?) -> Void){
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.getCheckVisit(placeId: placeId), callback: {(result: Result<VisitPostResponse, Error>) in
            switch result {
            case .success(let response):
                callback(response,nil)
            case .failure(let error):
                callback(nil,error)
            }
            
            
        })
        
    }
    
    
}
