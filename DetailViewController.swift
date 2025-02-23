import CoreData

class DetailViewController: UIViewController {
   
    @IBOutlet weak var TextLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UITextView!
    @IBOutlet weak var DescriptionImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var ad: ListModel?
       
    override func viewDidLoad() {
        super.viewDidLoad()
           
        if let ad = ad {
            configure(with: ad)
            checkIfFavorite()
        }
    }
       
    func configure(with ad: ListModel) {
        // Formatear el precio como moneda
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "es_ES") // Para formato europeo
        formatter.currencySymbol = "€"
        
        if let formattedPrice = formatter.string(from: NSNumber(value: ad.priceInfo)) {
            TextLabel.text = formattedPrice
        }
        
        DescriptionLabel.text = ad.description
           
        if let imageUrl = URL(string: ad.thumbnail) {
            DescriptionImage.kf.setImage(with: imageUrl)
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle() // Cambia el estado del botón
        if sender.isSelected {
            saveFavorite()
        } else {
            removeFavorite()
        }
    }
    
    private func saveFavorite() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let favoriteAd = FavoriteAd(context: context)
        favoriteAd.id = ad?.id // Asegúrate de que tu modelo tenga un identificador único
        favoriteAd.priceInfo = ad?.priceInfo ?? 0.0
        favoriteAd.description = ad?.description
        favoriteAd.thumbnail = ad?.thumbnail
        favoriteAd.municipality = ad?.municipality
        favoriteAd.district = ad?.district
        favoriteAd.bathrooms = Int16(ad?.bathrooms ?? 0)
        
        do {
            try context.save()
            print("Favorito guardado")
        } catch {
            print("Error al guardar el favorito: \(error)")
        }
    }
    
    private func removeFavorite() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<FavoriteAd> = FavoriteAd.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", ad?.id ?? "")
        
        do {
            let favorites = try context.fetch(fetchRequest)
            for favorite in favorites {
                context.delete(favorite)
            }
            try context.save()
            print("Favorito eliminado")
        } catch {
            print("Error al eliminar el favorito: \(error)")
        }
    }
    
    private func checkIfFavorite() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<FavoriteAd> = FavoriteAd.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", ad?.id ?? "")
        
        do {
            let favorites = try context.fetch(fetchRequest)
            favoriteButton.isSelected = !favorites.isEmpty
        } catch {
            print("Error al verificar favoritos: \(error)")
        }
    }
} 