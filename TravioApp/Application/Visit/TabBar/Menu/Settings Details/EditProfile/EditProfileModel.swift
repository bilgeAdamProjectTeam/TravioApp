//
//  EditProfileModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 7.09.2023.
//

import Foundation


struct UserReturn: Codable {
    var full_name: String
    var email: String
    var pp_url: String
    var role: String
    var created_at: String
}

struct EditRequest: Codable {
    var full_name: String
    var email: String
    var pp_url: String
}

struct EditResponse: Codable {
    var message: String
    var status: String
}

struct ProfileUploadResponse: Codable {
    let messageType: String
    let message: String
    let urls: [String]
}

