//
//  EditProfileViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 7.09.2023.
//

import Foundation
import UIKit
import Alamofire

class EditProfileViewModel{
    
    var userProfile: UserReturn?
    var url: [String] = []
    var image: [UIImage] = []
    
    func getUser(callback: @escaping (UserReturn) -> Void, errorCallback: @escaping(Error?) -> Void){
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.getProfile){ (result: Result<UserReturn, Error>) in
            switch result {
            case .success(let data):
                self.userProfile = data
                callback(data)
                errorCallback(nil)
            case .failure(let error):
                errorCallback(error)
            }
        }
    }
    
    
    func updateUser(input: EditRequest) /*, callback: @escaping (Error?) -> Void)*/{
        
        let params = ["full_name": input.full_name,
                      "email": input.email,
                      "pp_url": input.pp_url]
        
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.putProfile(parameters: params), callback: {(result: Result<EditResponse, Error>) in
            switch result {
            case .success:
                //callback(nil)
                print("success")
            case .failure(let error):
                //callback(error)
                print(error.localizedDescription)
            }
        })
    }
    
    func uploadPhoto(image: [Data?], callback: @escaping ([String]) -> Void) /*/, errorCallback: @escaping(Error?) -> Void)*/ {
        
        NetworkingHelper.shared.uploadImage(route: MyAPIRouter.postUpload(image: image)) {  (result: Result<ProfileUploadResponse, Error>) in
            switch result {
            case .success(let data):
                self.url = data.urls
                callback(self.url)
                //errorCallback(nil)
            case .failure(let error):
                //errorCallback(error)
                print("Hata:", error.localizedDescription)
            }
        }
        
    }
    
}
