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

class SecuritySettingsViewModel {
    
    var cameraPermission: Bool?
    var photoLibraryPermission: Bool?
    var locationServicesPermission: Bool?
    
    init() {
        // UserDefaults'tan izin durumlarını alırken opsiyonel değerleri çıkarıyoruz.
        self.cameraPermission = UserDefaults.standard.bool(forKey: "CameraPermission")
        self.photoLibraryPermission = UserDefaults.standard.bool(forKey: "PhotoLibraryPermission")
        self.locationServicesPermission = UserDefaults.standard.bool(forKey: "LocationServicesPermission")
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

