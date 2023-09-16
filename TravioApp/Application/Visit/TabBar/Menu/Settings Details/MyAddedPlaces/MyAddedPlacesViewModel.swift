//
//  MyAddedPlacesViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 13.09.2023.
//

import Foundation

class MyAddedPlacesViewModel{
    
    
    var myAddedPlaces: HomeResponse?
    
    func getMyAddedPlaces(callback: @escaping (HomeResponse?,Error?) -> Void){
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.getAllPlacesForUser, callback: { (result: Result<HomeResponse, Error>) in
            switch result {
            case .success(let myAddedPlaces):
                self.myAddedPlaces = myAddedPlaces
                callback(myAddedPlaces,nil)
            case .failure(let error):
                callback(nil,error)
            }
        })
        
    }
    
    
}
