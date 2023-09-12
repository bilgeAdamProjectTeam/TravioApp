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
       
    func login(input: LoginInfo, callback: @escaping (Error?) -> Void) {
           
           let param =  ["email": input.email,
                            "password": input.password]
           
           NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.postLogIn(parameters: param), callback: {(result: Result<LoginReturn, Error>) in
               switch result {
               case .success(let token):
                   let data = Data(token.accessToken.utf8)
                   self.saveToKeychain(data: data)
                   callback(nil)
                   print(token.accessToken)
               case .failure(let error):
                   callback(error)
                   print(error)
               }
           })
           
       }
    
}
