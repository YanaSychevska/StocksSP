//
//  Endpoints.swift
//  StocksSP
//
//  Created by YanaSychevska on 10.03.24.
//

import Foundation

enum Endpoints {
    case getHourlyBarsForTicker(ticker: String)
    case getStockDetails(ticker: String)
    case getSearchList(by: String)
    
    func getURL() -> URL? {
        var baseURLString = "https://api.polygon.io/"
        let apiKey = URLQueryItem(name: "apiKey", value: "XiTZnr6S483GNcMYZIfdBx1mew450yIf")
        
        switch self {
        case .getHourlyBarsForTicker(let ticker):let calendar = Calendar.current
            let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!
            let dayOfWeek = calendar.component(.weekday, from: yesterday)
            var dayToFetch = yesterday
            if dayOfWeek == 7 {
                dayToFetch = calendar.date(byAdding: .day, value: -1, to: yesterday)!
            } else if dayOfWeek == 1 {
                dayToFetch = calendar.date(byAdding: .day, value: -2, to: yesterday)!
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateStr = dateFormatter.string(from: dayToFetch)
            baseURLString += "v2/aggs/ticker/\(ticker)/range/1/hour/\(dateStr)/\(dateStr)"
            var baseURL = URL(string: baseURLString)
            let limit = URLQueryItem(name: "limit", value: "5000")
            baseURL?.append(queryItems: [limit, apiKey])
            return baseURL
        case .getStockDetails(let ticker):
            baseURLString += "v3/reference/tickers/\(ticker)"
            var baseURL = URL(string: baseURLString)
            baseURL?.append(queryItems: [apiKey])
            return baseURL
        case .getSearchList(let by):
            baseURLString += "v3/reference/tickers/"
            var baseURL = URL(string: baseURLString)
            let search = URLQueryItem(name: "search", value: by)
            let limit = URLQueryItem(name: "limit", value: "100")
            baseURL?.append(queryItems: [search, limit, apiKey])
            return baseURL
        }
    }
}
