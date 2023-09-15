//
//  SecuritySettingsViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 5.09.2023.
//

import Foundation

import Photos
import AVFoundation
import CoreLocation
import Alamofire
import UIKit

class SecuritySettingsViewModel {
    
    var cameraPermission: Bool?
    var photoLibraryPermission: Bool?
    var locationServicesPermission: Bool?
    var reloadClosure: (()->())?
    
    init() {
        
        }
    
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(updatePermission), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,name:UIApplication.didBecomeActiveNotification, object: nil)
    }
        
    @objc func updatePermission(){
        camPermission()
        photoPermission()
        locationPermission()
        reloadClosure?()

    }

    func camPermission(){
        
        let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)

        switch cameraStatus {
        case .authorized:
            cameraPermission = true
        case .denied, .restricted, .notDetermined:
            cameraPermission = false
        @unknown default:
            cameraPermission = false
            
        }
    }
    
    func photoPermission(){
        let photoStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoStatus {
        case .authorized:
            photoLibraryPermission = true
        case .denied, .restricted, .notDetermined, .limited :
            photoLibraryPermission = false
        @unknown default:
            photoLibraryPermission = false
        }
    }
    
    func locationPermission(){
        let locationStatus = CLLocationManager.authorizationStatus()

        switch locationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationServicesPermission = true
        case .notDetermined, .restricted, .denied:
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


