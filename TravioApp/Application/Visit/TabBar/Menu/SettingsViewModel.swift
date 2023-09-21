//
//  SettingsViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 4.09.2023.
//

import Foundation

class SettingsViewModel{
    
    
    var settingsArray = [Settings(icon: "securitySettings", labelName: "Security Settings"),
                     Settings(icon: "appDefaults", labelName: "App Defaults"),
                     Settings(icon: "myAddedPlaces", labelName: "My Added Places"),
                     Settings(icon: "user-alt", labelName: "Helps&Support"),
                     Settings(icon: "about", labelName: "About"),
                     Settings(icon: "termsOfUse", labelName: "Terms of Use")]
        
    var updateLoadingStatus: (()->())?
    
    var isLoading: Bool = false {
            didSet {
                self.updateLoadingStatus?()
            }
        }
    
    func getUsername(callback: @escaping (UserResponse?,Error?) -> Void){

        self.isLoading = true
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.getProfile){ (result: Result<UserResponse, Error>) in
            switch result {
            case .success(let data):
                self.isLoading = false
                callback(data,nil)
            case .failure(let error):
                callback(nil,error)
            }
        }
    }
    
}
