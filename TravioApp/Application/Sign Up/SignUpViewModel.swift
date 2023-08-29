//
//  SignUpViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import Alamofire
import Foundation

class SignUpViewModel {
    

       func register(input: RegisterInfo, callback: @escaping () -> Void) {
           
           let params = ["full_name": input.full_name,
                         "email": input.email,
                         "password": input.password]
           
           NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.postRegister(parameters: params), callback: {(result: Result<RegisterReturn, Error>) in
               switch result {
               case .success:
                   callback()
               case .failure(let error):
                   print("Hata:", error.localizedDescription)
               }
           })
           
       }
    
    
//    func register(input: RegisterInfo, callback: @escaping () -> Void) {
//        let url = "https://api.iosclass.live/v1/auth/register"
//
//        let params = ["full_name": input.full_name,
//                      "email": input.email,
//                      "password": input.password]
//
//        NetworkingHelper.shared.objectRequest(from: url, params: params, method: .post) { (result: Result<RegisterReturn, Error>) in
//            switch result {
//            case .success:
//                callback()
//
//            case .failure(let error):
//                print("Hata:", error.localizedDescription)
//            }
//        }
//    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
