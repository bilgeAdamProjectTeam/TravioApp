//
//  HomeModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 30.08.2023.
//

import Foundation

struct HomePlace: Codable {
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

struct HomeData: Codable {
    var count: Int
    var places: [HomePlace]
}

struct HomeResponse: Codable {
    var data: HomeData
    var status: String
}


