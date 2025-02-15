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
    
    func configure(with ad: ListModel) {
        titleLabel.text = ad.municipality
        descriptionLabel.text = ad.district
        
        if let imageUrl = URL(string: ad.thumbnail) {
            propertyImage.kf.setImage(with: imageUrl)
        }
    }
}
