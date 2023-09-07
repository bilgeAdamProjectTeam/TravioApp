//
//  EditProfileViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 7.09.2023.
//

import Foundation


class EditProfileViewModel{
    
    var userProfile: UserReturn?
    
    func getUser(callback: @escaping (UserReturn) -> Void){
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.getProfile){ (result: Result<UserReturn, Error>) in
            switch result {
            case .success(let data):
                self.userProfile = data
                callback(data)
            case .failure(let error):
                print("Hata:", error.localizedDescription)
                
            }
        }
    }
    
    
    func updateUser(input: EditRequest, callback: @escaping () -> Void){
        
        let params = ["full_name": input.full_name,
                      "email": input.email,
                      "pp_url": input.pp_url]
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.putProfile(parameters: params), callback: {(result: Result<EditResponse, Error>) in
            switch result {
            case .success:
                callback()
            case .failure(let error):
                print("Hata:", error.localizedDescription)
            }
        })
    }
    
}
