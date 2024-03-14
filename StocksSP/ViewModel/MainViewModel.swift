//
//  MainViewModel.swift
//  StocksSP
//
//  Created by YanaSychevska on 10.03.24.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var tickers: [String] = ["HD", "AAPL"]
    @Published var isSearchViewShown: Bool = false
    @Published var stocks: [StocksDailyBars] = []
    
    func gethHourlyBars() {
        stocks = []
        for ticker in tickers {
            let endpoint = Endpoints.getHourlyBarsForTicker(ticker: ticker)
            let url = endpoint.getURL()
            NetworkManager.shared.request(url: url, type: StocksDailyBars.self) { (response) in
                switch response {
                case .success(let obj):
                    DispatchQueue.main.async {
                        self.stocks.append(obj)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
