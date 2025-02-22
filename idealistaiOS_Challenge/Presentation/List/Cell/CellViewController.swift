//
//  CellViewController.swift
//  idealista_iOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 26/1/25.
//

import UIKit
import Kingfisher

class CellViewController: UITableViewCell {
    
    @IBOutlet weak var propertyImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    
    func configure(with ad: ListModel) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "es_ES")
        
        if let formattedPrice = formatter.string(from: NSNumber(value: ad.price)) {
            priceLabel.text = formattedPrice + " €"
            priceLabel.isAccessibilityElement = true
            priceLabel.accessibilityLabel = "Precio: \(formattedPrice) euros"
        }
        
        titleLabel.text = ad.municipality
        titleLabel.isAccessibilityElement = true
        titleLabel.accessibilityLabel = "Ubicación: \(ad.municipality)"
        
        descriptionLabel.text = ad.district
        descriptionLabel.isAccessibilityElement = true
        descriptionLabel.accessibilityLabel = "Barrio: \(ad.district)"
        
        floorLabel.text = "\(ad.bathrooms) Habitaciones"
        floorLabel.isAccessibilityElement = true
        floorLabel.accessibilityLabel = "\(ad.bathrooms) habitaciones disponibles"
        
        if let imageUrl = URL(string: ad.thumbnail) {
            propertyImage.kf.setImage(with: imageUrl)
            propertyImage.isAccessibilityElement = true
            propertyImage.accessibilityLabel = "Imagen del Inmueble en \(ad.municipality)"
        }
        
       
        self.isAccessibilityElement = true
        self.accessibilityElements = [propertyImage, titleLabel, priceLabel, floorLabel, descriptionLabel]
    }
}
