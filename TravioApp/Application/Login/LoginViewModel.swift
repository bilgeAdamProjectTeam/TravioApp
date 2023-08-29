//
//  LoginViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 28.08.2023.
//

import Foundation


class LoginViewModel {
    
    func saveToKeychain(data:Data) {
           KeychainHelper.standard.save(data, service: "access-token", account: "ios-class")
       }
       
       func login(input: LoginInfo) {
           
           let param =  ["email": input.email,
                            "password": input.password]
           
           NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.postLogIn(parameters: param), callback: {(result: Result<LoginReturn, Error>) in
               switch result {
               case .success(let token):
                   let data = Data(token.accessToken.utf8)
                   self.saveToKeychain(data: data)
                   print(token.accessToken)
               case .failure(let error):
                   print(error)
               }
           })
           
       }
    
//    func login(input: LoginInfo, callback: @escaping (Error?) -> Void) {
//
//        let params = ["email": input.email,
//                      "password": input.password]
//
//        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.postLogIn(parameters: params)) { (result: Result<LoginReturn, Error>) in
//            switch result {
//            case .success(let data):
//                _ = KeychainHelper.save(data.accessToken)
//                callback(nil)
//                print(data.accessToken)
//
//            case .failure(let error):
//                callback(error)
//                print("Hata:", error.localizedDescription)
//            }
//        }
//    }
}
