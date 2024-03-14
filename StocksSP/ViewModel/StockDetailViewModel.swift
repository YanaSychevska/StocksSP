//
//  StockDetailViewModel.swift
//  StocksSP
//
//  Created by YanaSychevska on 10.03.24.
//

import Foundation

class StockDetailViewModel: ObservableObject {
    @Published var stockInfo: StockDetails = StockDetails(name: "")
    
    func getStockDetails(for ticker: String) {
        let endpoint = Endpoints.getStockDetails(ticker: ticker)
        let url = endpoint.getURL()
        
        NetworkManager.shared.request(url: url, type: StockDetailsWrapper.self) { (response) in
            switch response {
            case .success(let obj):
                DispatchQueue.main.async {
                    self.stockInfo = obj.results
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
