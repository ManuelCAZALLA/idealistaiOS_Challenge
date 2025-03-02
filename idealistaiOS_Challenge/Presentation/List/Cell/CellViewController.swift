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
    @IBOutlet weak var municipalityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var bathroomsLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    
    func configure(with ad: ListModel) {
        municipalityLabel.text = ad.municipality
        addressLabel.text = ad.address
        districtLabel.text = ad.district
        bathroomsLabel.text = ad.bathrooms.description + " Hab"
       
        
        
        if let imageUrl = URL(string: ad.thumbnail) {
            propertyImage.kf.setImage(with: imageUrl)
        }
    }
}
