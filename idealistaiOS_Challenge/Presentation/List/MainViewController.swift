//
//  ViewController.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 13/2/25.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var ads: [ListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AdCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func fetchData() {
        let networkManager = BaseNetwork()
        networkManager.fetchAdList { [weak self] result in
            switch result {
            case .success(let ads):
                DispatchQueue.main.async {
                    self?.ads = ads
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error al obtener los anuncios: \(error)")
            }
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdCell", for: indexPath) as! CellViewController
        cell.configure(with: ads[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedAd = ads[indexPath.row]
        let detailVC = DetailViewController(nibName: "Detail", bundle: nil)
        detailVC.ad = selectedAd
        navigationController?.pushViewController(detailVC, animated: true)
    }
     
}
