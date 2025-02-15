//
//  CellViewController.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 13/2/25.
//

import UIKit

class DetailViewController: UIViewController {
   
    @IBOutlet weak var textLabel: UILabel!
    
    
    @IBOutlet weak var DescriptionLabel: UITextView!
    
    @IBOutlet weak var DescriptionImage: UIImageView!
    
    var ad: ListModel?
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
          if let ad = ad {
               configure(with: ad)
           }
       }
       
    func configure(with ad: ListModel) {
           
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "es_ES")
            formatter.currencySymbol = "€"
            
        if let formattedPrice = formatter.string(from: NSNumber(value: ad.price)) {
                textLabel.text = formattedPrice
            }
            
            DescriptionLabel.text = ad.description
               
            if let imageUrl = URL(string: ad.thumbnail) {
                DescriptionImage.kf.setImage(with: imageUrl)
            }
        }
   }

