//
//  DetailsModel.swift
//  idealista_iOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 31/12/24.
//

import Foundation

public struct DetailsModel: Codable {
    let adid: Int
    let price: Double
    let priceInfo: PriceInfo
    let operation: String
    let propertyType: String
    let extendedPropertyType: String
    let homeType: String
    let state: String
    let multimedia: Multimedia
    let propertyComment: String
    let ubication: Ubication
    let country: String
    let moreCharacteristics: MoreCharacteristics
    let energyCertification: EnergyCertification
}

struct Ubication: Codable {
    let latitude: Double
    let longitude: Double
}

struct MoreCharacteristics: Codable {
    let communityCosts: Double
    let roomNumber: Int
    let bathNumber: Int
    let exterior: Bool
    let housingFurnitures: String
    let agencyIsABank: Bool
    let energyCertificationType: String
    let flatLocation: String
    let modificationDate: Int64
    let constructedArea: Int
    let lift: Bool
    let boxroom: Bool
    let isDuplex: Bool
    let floor: String
    let status: String
}

struct EnergyCertification: Codable {
    let title: String
    let energyConsumption: CertificationDetail
    let emissions: CertificationDetail
}

struct CertificationDetail: Codable {
    let type: String
}

