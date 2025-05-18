//
//  UnsplashImageModel.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 17/5/25.
//

struct UnsplashSearchResult: Codable {
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Codable {
    let id: String
    let description: String?
    let alt_description: String?
    let urls: UnsplashPhotoURLs
}

struct UnsplashPhotoURLs: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
