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
    
    
    func getVisits(callback: @escaping (VisitResponse) -> Void){
        
        let params = ["page":1,"limit":10]
        
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.getVisits(parameters: params), callback: { (result: Result<VisitResponse, Error>) in
            switch result {
            case .success(let visits):
                self.visits = visits
                callback(visits)
            case .failure(let error):
                print("Hata:", error.localizedDescription)
            }
        })
    }
    
    
    func getVisitImage(placeId:String, callback: @escaping (ImageResponse) -> Void) {
        
        isLoadingDidChange?(true)
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.getAllImagesbyPlaceID(placeId: placeId), callback: {(result: Result<ImageResponse, Error>) in
            switch result {
            case .success(let images):
                self.images = images
                self.isLoadingDidChange?(false)
                callback(images)
            case .failure(let error):
                print("Hata:", error.localizedDescription)
            }
        })
    }
    
    
}
