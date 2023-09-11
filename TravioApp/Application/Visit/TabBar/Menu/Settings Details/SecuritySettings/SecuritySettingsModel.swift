//
//  SecuritySettingsModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 5.09.2023.
//

import Foundation



struct ChangePassword {
    var labelName: String
    var tag:Int
}

struct PrivacyInfo {
    var labelName: String
    var switchCheck: Bool
}

struct PasswordRequest:Codable {
    var new_password: String
}

struct PasswordResponse: Codable {
    var message: String
    var status: String
}


