//
//  SecuritySettingsViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 5.09.2023.
//

import Foundation

//class SecuritySettingsViewModel{
//
//
//    var cameraPermission = UserDefaults.standard.value(forKey: "CameraPermission") as? Bool
//    var photoLibraryPermission = UserDefaults.standard.value(forKey: "PhotoLibraryPermission") as? Bool
//    var locationServicesPermission = UserDefaults.standard.value(forKey: "LocationServicesPermission") as? Bool
//
//
//
//    var changePassWordInfo = [ChangePassword(labelName: "New Password"),
//                              ChangePassword(labelName: "New Password Confirm")]
//
//    var privacyInfo = [PrivacyInfo(labelName: "Camera", switchCheck: cameraPermission ?? false),
//                       PrivacyInfo(labelName: "Photo Library", switchCheck: photoLibraryPermission ?? false),
//                       PrivacyInfo(labelName: "Location", switchCheck: locationServicesPermission ?? false)]
//
//}
import Photos
import AVFoundation
import CoreLocation
import Alamofire

class SecuritySettingsViewModel {
    
    var cameraPermission: Bool?
    var photoLibraryPermission: Bool?
    var locationServicesPermission: Bool?
    
    init() {
        
        let photoStatus = PHPhotoLibrary.authorizationStatus()
        let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)
        let locationStatus = CLLocationManager.authorizationStatus()
        
        switch photoStatus {
        case .authorized:
            photoLibraryPermission = true
        case .denied, .restricted, .notDetermined, .limited :
            photoLibraryPermission = false
        @unknown default:
            photoLibraryPermission = false
        }
        
        switch cameraStatus {
        case .authorized:
            cameraPermission = true
        case .denied, .restricted, .notDetermined:
            cameraPermission = false
        @unknown default:
            cameraPermission = false
        }
        
        switch locationStatus {
        case .authorizedAlways:
            locationServicesPermission = true
        case .authorizedWhenInUse, .notDetermined, .restricted, .denied:
            locationServicesPermission = false
        @unknown default:
            locationServicesPermission = false
        }
    }
    
    var changePassWordInfo = [ChangePassword(labelName: "New Password",tag:0),
                              ChangePassword(labelName: "New Password Confirm", tag:1)]

    var privacyInfo: [PrivacyInfo] {
        return [
            PrivacyInfo(labelName: "Camera", switchCheck: cameraPermission ?? true),
            PrivacyInfo(labelName: "Photo Library", switchCheck: photoLibraryPermission ?? true),
            PrivacyInfo(labelName: "Location", switchCheck: locationServicesPermission ?? true)
        ]
    }
    
    
    func changePassword(parameters: Parameters, errorCallback: @escaping(Error?) -> Void){
        NetworkingHelper.shared.objectRequestRouter(request: MyAPIRouter.putPassword(parameters: parameters), callback: {(result: Result<PasswordResponse, Error>) in
            switch result {
            case .success(let data):
                errorCallback(nil)
            case .failure(let error):
                errorCallback(error)
            }
        })
    }
    

}


