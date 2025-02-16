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
            }
            
        descriptionLabel.text = ad.district
        titleLabel.text = ad.municipality
        floorLabel.text = ad.bathrooms.description + " Habitaciones"
               
            if let imageUrl = URL(string: ad.thumbnail) {
                propertyImage.kf.setImage(with: imageUrl)
            }
        }
}
