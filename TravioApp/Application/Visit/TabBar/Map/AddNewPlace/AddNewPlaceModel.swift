//
//  AddNewPlaceModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import Foundation


struct UploadResponse: Codable {
    let messageType: String
    let message: String
    let urls: [String]
}


//{
//    "messageType": "S",
//    "message": "Files uploaded successfully",
//    "urls": [
//     "https://iosclass.ams3.digitaloceanspaces.com/1631234567890.jpg",
//     "https://iosclass.ams3.digitaloceanspaces.com/1631234567891.jpg"
//   ]
// }
