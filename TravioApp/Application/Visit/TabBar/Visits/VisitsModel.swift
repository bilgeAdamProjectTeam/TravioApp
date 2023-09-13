//
//  VisitsModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import Foundation

struct VisitResponse: Codable {
    var data: VisitData
    var status: String
}

struct VisitData: Codable {
    var count: Int
    var visits: [Visit]
}

struct Visit: Codable {
    var id: String
    var place_id: String
    var visited_at: String
    var created_at: String
    var updated_at: String
    var place: VisitPlace
}

struct VisitPlace: Codable {
    var id: String
    var creator: String
    var place: String
    var title: String
    var description: String
    var cover_image_url: String
    var latitude: Double
    var longitude: Double
    var created_at: String
    var updated_at: String
}

struct VisitPostResponse: Codable {
    var message: String
    var status: String
}


struct ImageResponse: Codable {
    var data: ImageData
    var status: String
}

struct ImageData: Codable {
    var images: [Image]
    var count: Int
}

struct Image: Codable {
    var id: String
    var place_id: String
    var image_url: String
    var created_at: String
    var updated_at: String
}


struct PlaceResponseNew: Codable {
    var data: PlaceDataNew
    var status: String
}

struct PlaceDataNew: Codable {
    var place: PlaceNew
}

struct PlaceNew: Codable {
    var id, creator, place, title: String
    var description: String
    var cover_image_url: String
    var latitude, longitude: Double
    var created_at, updated_at: String
}
