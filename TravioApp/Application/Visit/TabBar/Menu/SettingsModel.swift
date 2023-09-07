//
//  SettingsModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 4.09.2023.
//

import Foundation

struct Settings {
    var icon: String
    var labelName: String
}


struct UserResponse: Codable {
    var full_name: String
    var email: String
    var pp_url: String
    var role: String
    var created_at: String
}


