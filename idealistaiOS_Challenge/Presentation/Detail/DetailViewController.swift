//
//  CellViewController.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 13/2/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UITextView!
    @IBOutlet weak var DescriptionImage: UIImageView!
    
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        guard let ad = ad else { return }
        
        let id = UUID()
        
        if CoreDataManager.shared.isFavorite(id: id) {
            CoreDataManager.shared.deleteFavorite(id: id)
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            CoreDataManager.shared.saveFavorite(id: id, title: ad.municipality, price: ad.price, address: ad.address, imageURL: ad.thumbnail)
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        sender.isSelected.toggle()
    }
    
    var ad: ListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let ad = ad {
            configure(with: ad)
        }
    }
    
    func configure(with ad: ListModel) {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "es_ES")
        formatter.currencySymbol = "€"
        
        if let formattedPrice = formatter.string(from: NSNumber(value: ad.price)) {
            textLabel.text = formattedPrice
        }
        
        DescriptionLabel.text = ad.description
        addressLabel.text = ad.address
        
        
        if let imageUrl = URL(string: ad.thumbnail) {
            DescriptionImage.kf.setImage(with: imageUrl)
        }
    }
}

