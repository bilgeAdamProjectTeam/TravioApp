//
//  VisitsViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

//import Foundation
//import Alamofire
//
//class VisitsViewModel {
//    var arr:TravelResponse?
//    var imagesArr:ImageResponse?
//    var arrDetail:Travel?
//    var isLoading: Bool?
//    
//    var isLoadingDidChange: ((Bool) -> Void)?
//    
//    func getData( callback: @escaping (TravelResponse) -> Void){
//        let url = "https://api.iosclass.live/v1/travels?page=1&limit=10"
//        
//        if let token = KeychainHelper.loadAccessToken() {
//            let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
//            
//            NetworkingHelper.shared.objectRequestwithHeader(from: url, params: [:], method: .get, header: headers, callback: { (result: Result<TravelResponse, Error>) in
//                switch result {
//                case .success(let travels):
//                    self.arr = travels
//                    
//                    callback(travels)
//                case .failure(let error):
//                    print("Hata:", error.localizedDescription)
//                }
//            })
//        }
//    }
//    
//    
//    
//    func getImages(id:String, callback: @escaping () -> Void){
//        //var travelId = ""
//        let url = "https://api.iosclass.live/v1/galleries/\(id)"
//        
//        if let token = KeychainHelper.loadAccessToken() {
//            let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
//            isLoadingDidChange?(true)
//            
//            NetworkingHelper.shared.objectRequestwithHeader(from: url, params: [:], method: .get, header: headers, callback: { (result: Result<ImageResponse, Error>) in
//                switch result {
//                case .success(let imageResponse):
//                    sleep(3)
//                    self.imagesArr = imageResponse
//                    
//                    self.isLoadingDidChange?(false)
//                    callback()
//                case .failure(let error):
//                    print("Hata:", error.localizedDescription)
//                }
//            })
//        }
//    }
//    
//    
//    
//    func getData2( callback: @escaping (TravelResponse) -> Void){
//        //        let url = "https://api.iosclass.live/v1/travels?page=1&limit=10"
//        
//        let params = ["page":1,"limit":10]
//        
//        
//        NetworkingHelper.shared.objectRequestNew(request:MyAPIRouter.getListTravel(params: params) , callback: { (result: Result<TravelResponse, Error>) in
//            switch result {
//            case .success(let travels):
//                self.arr = travels
//                callback(travels)
//            case .failure(let error):
//                print("Hata:", error.localizedDescription)
//            }
//        })
//    }
//    
//    
//}
