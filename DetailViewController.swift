class DetailViewController: UIViewController {
   
    @IBOutlet weak var TextLabel: UILabel!
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
} 