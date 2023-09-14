//
//  NetworkHelper.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 28.08.2023.
//

import Foundation
import Alamofire

class NetworkingHelper {
    
    static let shared = NetworkingHelper()
    
    func objectRequestRouter<T:Codable>(request: URLRequestConvertible, callback: @escaping (Result<T,Error>) -> Void) {
        
        AF.request(request).responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value)
                    let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
                    callback(.success(decodedData))
                } catch {
                    callback(.failure(error))
                }
            case .failure(let err):
                callback(.failure(err))
            }
        }
        
    }
    
    
    func uploadImage<T: Codable>(route: MyAPIRouter, callback: @escaping (Result<T,Error>) -> Void){
        
        
        let request: URLRequestConvertible = route
        
        AF.upload(multipartFormData: route.multipartFormData , with: request).validate()
            .responseData {response in
                switch response.result {
                case .success(let data):
                    do {
                        
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        callback(.success(decodedData))
                    } catch {
                        callback(.failure(error))
                    }
                case .failure(let err):
                    callback(.failure(err))
                }
            }
    }
}
