//
//  CoreDataManager.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 25/2/25.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "idealistaiOS_Challenge")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error al cargar Core Data: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveFavorite(id: Int32, title: String, price: Double, address: String, imageURL: String) {
        let favorite = FavoriteAd(context: context)
        favorite.id = id
        favorite.municipality = title
        favorite.priceInfo = price
        favorite.district = address
        favorite.thumbnail = imageURL
        
        do {
            try context.save()
            print("Guardado en favoritos ✅")
        } catch {
            print("Error al guardar: \(error)")
        }
    }
    
    func deleteFavorite(id: Int32) {
        let request: NSFetchRequest<FavoriteAd> = FavoriteAd.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try context.fetch(request)
            if let favorite = results.first {
                context.delete(favorite)
                try context.save()
                print("Eliminado de favoritos ❌")
            }
        } catch {
            print("Error al eliminar: \(error)")
        }
    }
    
    func isFavorite(id: Int32) -> Bool {
        let request: NSFetchRequest<FavoriteAd> = FavoriteAd.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            return false
        }
    }
    
    func fetchFavorites() -> [FavoriteAd] {
        let request: NSFetchRequest<FavoriteAd> = FavoriteAd.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error al obtener favoritos: \(error)")
            return []
        }
    }
}
