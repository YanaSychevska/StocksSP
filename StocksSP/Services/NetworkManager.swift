//
//  NetworkManager.swift
//  StocksSP
//
//  Created by YanaSychevska on 08.03.24.
//

import SwiftUI
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    
    func request<T: Decodable>(url: URL?, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        if let url = url {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } else {
            print("There is no URl")
        }
    }
}
