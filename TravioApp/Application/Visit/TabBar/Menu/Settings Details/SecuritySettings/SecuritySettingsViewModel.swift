//
//  SecuritySettingsViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 5.09.2023.
//

import Foundation

class SecuritySettingsViewModel{
    
    var changePassWordInfo = [ChangePassword(labelName: "New Password"),
                              ChangePassword(labelName: "New Password Confirm")]

    var privacyInfo = [PrivacyInfo(labelName: "Camera", switchCheck: true),
                       PrivacyInfo(labelName: "Photo Library", switchCheck: false),
                       PrivacyInfo(labelName: "Location", switchCheck: true)]
    
}
