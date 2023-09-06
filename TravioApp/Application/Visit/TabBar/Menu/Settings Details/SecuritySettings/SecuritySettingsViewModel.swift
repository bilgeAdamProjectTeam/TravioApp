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

class SecuritySettingsViewModel {
    
    var cameraPermission: Bool?
    var photoLibraryPermission: Bool?
    var locationServicesPermission: Bool?
    
    init() {
        
        let photoStatus = PHPhotoLibrary.authorizationStatus()
        let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)
        let locationStatus = CLLocationManager.authorizationStatus()
        
        
        if photoStatus == .authorized || cameraStatus == .authorized || locationStatus == .authorizedAlways{
            cameraPermission = true
            photoLibraryPermission = true
            locationServicesPermission = true
        }else{
            cameraPermission = false
            photoLibraryPermission = false
            locationServicesPermission = false
        }
        
    }
    
    var changePassWordInfo = [ChangePassword(labelName: "New Password"),
                              ChangePassword(labelName: "New Password Confirm")]

    var privacyInfo: [PrivacyInfo] {
        return [
            PrivacyInfo(labelName: "Camera", switchCheck: cameraPermission ?? false),
            PrivacyInfo(labelName: "Photo Library", switchCheck: photoLibraryPermission ?? false),
            PrivacyInfo(labelName: "Location", switchCheck: locationServicesPermission ?? false)
        ]
    }
}

