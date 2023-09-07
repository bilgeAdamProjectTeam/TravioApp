//
//  MapViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import Foundation
import Alamofire

class MapViewModel{
    
    var placeArr: PlaceResponse?
    
    func getAllPlace(callback: @escaping (PlaceResponse) -> Void){
        
        let params = ["page":1, "limit":50]
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.getAllPlaces(parameters: params)){ (result: Result<PlaceResponse, Error>) in
            switch result {
            case .success(let places):
                self.placeArr = places
                callback(places)
            case .failure(let error):
                print("Hata:", error.localizedDescription)
            }
        }
    }
    
}



