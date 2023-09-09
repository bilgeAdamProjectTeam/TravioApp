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
    var status: String
}

struct GalleryInfo: Codable {
    var place_id: String
    var image_url: String
}


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
