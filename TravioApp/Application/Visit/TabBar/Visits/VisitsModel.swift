//
//  VisitsModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import Foundation

struct TravelResponse: Codable {
    let data: TravelData
    let status: String
}

struct TravelData: Codable {
    let count: Int
    let travels: [Travel]
}

struct Travel: Codable {
    let id: String
    let visit_date: String
    let location: String
    let information: String
    let image_url: String
    let latitude: Double
    let longitude: Double
    let created_at: String
    let updated_at: String
}



struct ImageResponse: Codable {
    let data: ImageData
    let status: String
}

struct ImageData: Codable {
    let images: [Image]
    let count: Int
}

struct Image: Codable {
    let id: String
    let travel_id: String
    let image_url: String
    let caption: String
    let created_at: String
    let updated_at: String
}
