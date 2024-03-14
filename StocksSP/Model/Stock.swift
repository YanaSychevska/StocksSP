//
//  Stock.swift
//  StocksSP
//
//  Created by YanaSychevska on 08.03.24.
//

import Foundation

class Initial: Codable {
    let results: [StockOpenClose]
}

class StockOpenClose: Codable {
//    let ticker: String
//    let name: String
    let symbol: String
    let open: Float
    let close: Float
}

extension StockOpenClose {
    var isStockUp: Bool {
        return self.open < self.close
    }
}
