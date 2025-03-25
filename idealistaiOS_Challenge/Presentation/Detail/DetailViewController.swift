//
//  CellViewController.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 13/2/25.
//

import UIKit
import CoreData
import Kingfisher
import SwiftUI

class DetailViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var mapButton: UIButton!
    var ad: DetailsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFavoriteButton()
        setupCollectionView()
        configureView()
        checkIfFavorite()
    }
    
    // MARK: - Configuración inicial
    private func setupFavoriteButton() {
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium)
        favoriteButton.setImage(UIImage(systemName: "heart", withConfiguration: config), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: .selected)
        favoriteButton.tintColor = .red
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CellCollectionView", bundle: nil), forCellWithReuseIdentifier: "imageCell")
    }
    
    private func configureView() {
        guard let ad = ad else { return }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "es_ES")
        formatter.currencySymbol = "€"
        
        textLabel.text = formatter.string(from: NSNumber(value: ad.price))
        descriptionLabel.text = ad.propertyComment
        addressLabel.text = ad.operation.uppercased()
        
        collectionView.reloadData()
    }
    
    // MARK: - Gestión de Favoritos
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.isSelected ? saveFavorite() : removeFavorite()
    }
    
    private func checkIfFavorite() {
        guard let adID = ad?.adid else { return }
        favoriteButton.isSelected = FavoritesManager.shared.isFavorite(adID: Int32(adID))
    }
    
    private func saveFavorite() {
        guard let ad = ad else { return }
        FavoritesManager.shared.saveFavorite(ad: ad)
    }
    
    private func removeFavorite() {
        guard let adID = ad?.adid else { return }
        FavoritesManager.shared.removeFavorite(adID: Int32(adID))
    }
    
    @IBAction func mapButton(_ sender: Any) {
        guard let ad = ad else { return }
        
        let mapVC = MapViewController()
        mapVC.property = ad
        navigationController?.pushViewController(mapVC, animated: true)
    }
}


// MARK: - UICollectionViewDataSource & Delegate

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ad?.multimedia.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        if let imageUrlString = ad?.multimedia.images[indexPath.item].url, let imageUrl = URL(string: imageUrlString) {
            imageView.kf.setImage(with: imageUrl)
        }
        
        cell.contentView.addSubview(imageView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let images = ad?.multimedia.images.map({ $0.url }) else { return }
        let imagePreviewVC = UIHostingController(rootView: ImagePreviewView(imageUrls: images))
        present(imagePreviewVC, animated: true, completion: nil)
    }
}
