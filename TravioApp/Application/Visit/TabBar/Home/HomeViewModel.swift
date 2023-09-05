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
    
    var popularPlacesArray: [HomePlace] = []
    var lastPlacesArray: [HomePlace] = []
    
    var serviceDataArray: [[HomePlace]] = [[]]
    
    var dispatchGroup = DispatchGroup()
    
    func getPopulerPlaces(callback: @escaping (HomeResponse) -> Void) {
        
        let params = ["limit":5]
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.getPopularPlaces(parameters: params), callback: { (result: Result<HomeResponse, Error>) in
            switch result {
            case .success(let popularPlaces):
                self.popularPlaces = popularPlaces
                self.popularPlacesArray.append(contentsOf: popularPlaces.data.places)
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
                self.lastPlacesArray.append(contentsOf: lastPlaces.data.places)
                callback(lastPlaces)
            case .failure(let error):
                print("Error:", error.localizedDescription)
            }
        })
        
    }
    
    
//    func fetchHomeData(callback: @escaping ([[HomePlace]]) -> Void) {
//        dispatchGroup.enter()
//        getPopulerPlaces { result in
//            self.serviceDataArray.append(self.popularPlacesArray)
//            self.dispatchGroup.leave()
//        }
//
//        dispatchGroup.enter()
//        getLastPlaces { result in
//            self.serviceDataArray.append(self.lastPlacesArray)
//            self.dispatchGroup.leave()
//        }
//
//        dispatchGroup.notify(queue: .main) {
//            callback(self.serviceDataArray)
//
//        }
//    }
    
    func fetchHomeData(callback: @escaping ([[HomePlace]]) -> Void) {
        
        
        getPopulerPlaces { HomeResponse in
            self.serviceDataArray[0].append(contentsOf: self.popularPlacesArray)
        }
        
        getLastPlaces { HomeResponse in
            self.serviceDataArray[1].append(contentsOf: self.lastPlacesArray)
        }
          
        callback(self.serviceDataArray)
        print(serviceDataArray)
        
    }

}

