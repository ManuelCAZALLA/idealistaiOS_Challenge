//
//  ListModel.swift
//  idealista_iOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 31/12/24.
//

import Foundation

public struct ListModel: Codable {
    let propertyCode: String
    let thumbnail: String
    let floor: String
    let price: Double
    let priceInfo: PriceInfo
    let propertyType: String
    let operation: String
    let size: Double
    let exterior: Bool
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let municipality: String
    let district: String
    let country: String
    let neighborhood: String
    let latitude: Double
    let longitude: Double
    let description: String
    let multimedia: Multimedia
    let features: Features?
}

struct PriceInfo: Codable {
    let price: PriceDetail
}

struct PriceDetail: Codable {
    let amount: Double
    let currencySuffix: String
}

struct Multimedia: Codable {
    let images: [Image]
}

struct Image: Codable {
    let url: String
    let tag: String
}

struct Features: Codable {
    let hasAirConditioning: Bool?
    let hasBoxRoom: Bool?
    let hasSwimmingPool: Bool?
    let hasTerrace: Bool?
    let hasGarden: Bool?
}

