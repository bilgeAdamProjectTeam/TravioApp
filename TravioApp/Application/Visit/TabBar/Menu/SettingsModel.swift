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
    var id: String
    var full_name: String
    var email: String
    var role: String
    var created_at: String
    var updated_at: String
    
}


//{
//"id": "user_id",
//"full_name": "John Doe",
//"email": "johndoe@example.com",
//"role": "user_role",
//"created_at": "2023-08-05T12:34:56Z",
//"updated_at": "2023-08-05T12:34:56Z"
//}
