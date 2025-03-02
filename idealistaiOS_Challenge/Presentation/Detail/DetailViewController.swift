//
//  CellViewController.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 13/2/25.
//

import UIKit
import CoreData
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
   
    
    
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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
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
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<FavoriteAd> = FavoriteAd.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", adID)
        
        do {
            favoriteButton.isSelected = try context.count(for: request) > 0
        } catch {
            print("Error al verificar favoritos: \(error)")
        }
    }
    
    private func saveFavorite() {
        guard let ad = ad else { return }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let favoriteAd = FavoriteAd(context: context)
        favoriteAd.id = Int32(ad.adid)
        favoriteAd.priceInfo = ad.price
        favoriteAd.descriptions = ad.propertyComment
        favoriteAd.thumbnail = ad.multimedia.images.first?.url ?? ""
        favoriteAd.municipality = ad.country
        favoriteAd.district = ad.ubication.latitude.description
        
        do {
            try context.save()
            print("Favorito guardado ✅")
        } catch {
            print("Error al guardar el favorito: \(error)")
        }
    }
    
    private func removeFavorite() {
        guard let adID = ad?.adid else { return }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<FavoriteAd> = FavoriteAd.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", adID)
        
        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            try context.save()
            print("Favorito eliminado ❌")
        } catch {
            print("Error al eliminar el favorito: \(error)")
        }
    }
}

// MARK: - UICollectionViewDataSource & Delegate
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ad?.multimedia.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        
        // Asegúrate de que el contenido de la celda se configure correctamente
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        if let imageUrlString = ad?.multimedia.images[indexPath.item].url, let imageUrl = URL(string: imageUrlString) {
            imageView.kf.setImage(with: imageUrl)
        }
        
        // Eliminar subviews anteriores y agregar la nueva imagen
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        cell.contentView.addSubview(imageView)
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.height)
    }
}
