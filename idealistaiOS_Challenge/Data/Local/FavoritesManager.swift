//
//  FavoritesManager.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 2/3/25.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    private let coreDataManager = CoreDataManager.shared

    private init() {}

   func isFavorite(adID: Int32) -> Bool {
        return coreDataManager.isFavorite(id: adID)
    }

    func saveFavorite(ad: DetailsModel) {
        let imageURL = ad.multimedia.images.first?.url ?? ""
        coreDataManager.saveFavorite(
            id: Int32(ad.adid),
            title: ad.country,
            price: ad.price,
            address: ad.ubication.latitude.description,
            imageURL: imageURL
        )
    }

    func removeFavorite(adID: Int32) {
        coreDataManager.deleteFavorite(id: adID)
    }

    func getAllFavorites() -> [FavoriteAd] {
        return coreDataManager.fetchFavorites()
    }
}
