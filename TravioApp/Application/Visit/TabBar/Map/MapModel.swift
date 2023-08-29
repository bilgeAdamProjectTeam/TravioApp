//
//  MapModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import Foundation

// MARK: - MapModel
struct PlaceResponse: Codable {
    var data: PlaceData?
    var status: String?
}

// MARK: - DataClass
struct PlaceData: Codable {
    var count: Int?
    var places: [Place]?
}

// MARK: - Place
struct Place: Codable {
    var id, creator, place, title: String?
    var description: String?
    var coverImageURL: String?
    var latitude, longitude: Double?
    var createdAt, updatedAt: String?
    init() {}

    enum CodingKeys: String, CodingKey {
        case id, creator, place, title, description
        case coverImageURL = "cover_image_url"
        case latitude, longitude
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
