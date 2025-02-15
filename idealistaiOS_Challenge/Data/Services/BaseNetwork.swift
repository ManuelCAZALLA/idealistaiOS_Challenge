//
//  BaseNetwork.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 13/2/25.
//

import Foundation

// MARK: - Protocol
public protocol BaseNetworkProtocol {
    func fetchAdList(completion: ((Result<[ListModel], APIError>) -> Void)?)
    func fetchAdDetail(completion: ((Result<DetailsModel, APIError>) -> Void)?)
}

// MARK: - API Manager Implementation
public class BaseNetwork: BaseNetworkProtocol {
    
   private let listURL = URL(string: "https://idealista.github.io/ios-challenge/list.json")!
   
    private let detailURL = URL(string: "https://idealista.github.io/ios-challenge/detail.json")!
    
    // MARK: - Fetch List
    public func fetchAdList(completion: ((Result<[ListModel], APIError>) -> Void)?) {
        var urlRequest = URLRequest(url: listURL)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("Error: \(String(describing: error))")
                completion?(.failure(.unknown))
                return
            }
            
            guard let data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                print("No Data or Bad Status Code")
                completion?(.failure(.noData))
                return
            }
            
            do {
                let ads = try JSONDecoder().decode([ListModel].self, from: data)
                print("Datos de anuncios recibidos: \(ads)")
                completion?(.success(ads))
            } catch {
                print("Error al decodificar los datos: \(error)")
                completion?(.failure(.decodingFailed))
            }
        }
        task.resume()
    }
    
    // MARK: - Fetch Ad Detail
    public func fetchAdDetail(completion: ((Result<DetailsModel, APIError>) -> Void)?) {
        var urlRequest = URLRequest(url: detailURL)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("Error: \(String(describing: error))")
                completion?(.failure(.unknown))
                return
            }
            
            guard let data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                print("No Data or Bad Status Code")
                completion?(.failure(.noData))
                return
            }
            
            do {
                let adDetail = try JSONDecoder().decode(DetailsModel.self, from: data)
                print("Detalles del anuncio recibidos: \(adDetail)")
                completion?(.success(adDetail))
            } catch {
                print("Error al decodificar los detalles: \(error)")
                completion?(.failure(.decodingFailed))
            }
        }
        task.resume()
    }
}



