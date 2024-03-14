//
//  SearchSheetViewModel.swift
//  StocksSP
//
//  Created by YanaSychevska on 10.03.24.
//

import SwiftUI
import Combine

class SearchSheetViewModel: ObservableObject {
    var subscription: Set<AnyCancellable> = []
    @Published var searchText: String = ""
    @Published var tickers: [Ticker]? = []
    
    init() {
        $searchText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 {
                    self.tickers = []
                    return nil
                }
                
                return string
            })
            .compactMap{ $0 }
            .sink { (_) in
            } receiveValue: { [weak self] _ in
                self?.getSearchList()
            }.store(in: &subscription)
    }
    
    func getSearchList() {
        let endpoint = Endpoints.getSearchList(by: searchText)
        let url = endpoint.getURL()
        
        NetworkManager.shared.request(url: url, type: TickerWrapper.self) { (response) in
            switch response {
            case .success(let obj):
                DispatchQueue.main.async {
                    self.tickers = obj.results
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
