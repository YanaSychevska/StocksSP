//
//  StocksDailyBars.swift
//  StocksSP
//
//  Created by YanaSychevska on 08.03.24.
//

import Foundation

class StocksDailyBars: Codable {
    let results: [StocksHourlyBars]?
    let ticker: String
    
    init(results: [StocksHourlyBars], ticker: String) {
        self.results = results
        self.ticker = ticker
    }
}

class StocksHourlyBars: Codable, Identifiable {
    let o: Double
    let c: Double
    let h: Double
    let l: Double
    let v: Double
    let vw: Double
    let t: Int
    
    init(open: Double,
         close: Double,
         high: Double,
         low: Double,
         volume: Double,
         volumeWeight: Double,
         timestamp: Int) {
        self.o = open
        self.c = close
        self.h = high
        self.l = low
        self.v = volume
        self.vw = volumeWeight
        self.t = timestamp
    }
}

extension StocksHourlyBars {
    var hourOfAgrWindow: Int {
        let date = Date(timeIntervalSince1970: TimeInterval(t/1000))
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour
    }
}

extension StocksDailyBars {
    var isGoesUp: Bool? {
        if let close = results?.last?.c, let open = results?.first?.o {
            return open < close
        }
        return nil
    }
    
    var openPriceS: String {
        getPriceString(for: results?.first?.o)
    }
    
    var closePriceS: String {
        return getPriceString(for: results?.last?.c)
    }
    
    var volWeightPriceS: String {
        return getPriceString(for: (results?.last?.vw))
    }
    
    var lowPriceD: Double {
        guard let results = results else { return 0.0 }
        let newArr = results.map({$0.l})
        return newArr.min() ?? 0.0
    }
    
    var lowPriceS: String {
        guard let results = results else { return "--" }
        let newArr = results.map({$0.l})
        return getPriceString(for: newArr.min())
    }
    
    var highPriceS: String {
        guard let results = results else { return "--" }
        let newArr = results.map({$0.h})
        return getPriceString(for: newArr.max())
    }
    
    var highPriceD: Double {
        guard let results = results else { return 0.0 }
        let newArr = results.map({$0.h})
        return newArr.max() ?? 0.0
    }
    
    var volPriceS: String {
        return getPriceString(for: (results?.last?.v))
    }
    
    func getPriceString(for price: Double?) -> String {
        guard let pr = price else { return "--" }
        return String(format:"%.2f", pr)
    }
}
