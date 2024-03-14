//
//  Ticker.swift
//  StocksSP
//
//  Created by YanaSychevska on 10.03.24.
//

import Foundation

class TickerWrapper: Codable {
    let results: [Ticker]?
}

class Ticker: Codable, Identifiable {
    let name: String
    let ticker: String
}
