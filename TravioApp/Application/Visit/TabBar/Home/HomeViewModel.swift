//
//  HomeViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 30.08.2023.
//

import Foundation
import Alamofire

class HomeViewModel {
    
    var popularPlaces: HomeResponse?
    var lastPlaces: HomeResponse?
    
    func getPopulerPlaces(callback: @escaping (HomeResponse) -> Void) {
        
        let params = ["limit":5]
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.getPopularPlaces(parameters: params), callback: { (result: Result<HomeResponse, Error>) in
            switch result {
            case .success(let popularPlaces):
                self.popularPlaces = popularPlaces
                callback(popularPlaces)
            case .failure(let error):
                print("Error:", error.localizedDescription)
            }
        })

    }
    
    func getLastPlaces(callback: @escaping (HomeResponse) -> Void) {
        
        let params = ["limit":5]
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.getLastPlaces(parameters: params), callback: { (result: Result<HomeResponse, Error>) in
            switch result {
            case .success(let lastPlaces):
                self.lastPlaces = lastPlaces
                callback(lastPlaces)
            case .failure(let error):
                print("Error:", error.localizedDescription)
            }
        })
        
    }
    
}

