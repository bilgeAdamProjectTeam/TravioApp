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

struct GalleryResponse: Codable {
    var message: String
    var image_url: String
}

struct GalleryInfo: Codable {
    var place_id: String
    var image_url: String
}

//Gallery parameters
//{
//    "place_id": "358c3c03-a66a-4d03-adc7-84a1d9874d6e",
//    "image_url": "https://example.com/animage.png"
//}


struct PlacesResponse:Codable {
    var message: String
    var status: String
}

struct PlaceInfo: Codable {
    var place: String
    var title: String
    var description: String
    var cover_image_url: String
    var latitude: Double
    var longitude: Double
}

//PostPlace parameters
//{
//      "place": "Nevşehir, Türkiye",
//      "title": "Kapadokya",
//      "description": "Kapadokya, adeta peri masallarının gerçeğe dönüştüğü büyülü bir dünyadır.",
//      "cover_image_url": "https://iosclass.ams3.digitaloceanspaces.com/1692817007606598873.png",
//      "latitude": 38.6431,
//      "longitude": 34.8287
//}




//{
//    "messageType": "S",
//    "message": "Files uploaded successfully",
//    "urls": [
//     "https://iosclass.ams3.digitaloceanspaces.com/1631234567890.jpg",
//     "https://iosclass.ams3.digitaloceanspaces.com/1631234567891.jpg"
//   ]
// }
