//
//  StockDetails.swift
//  StocksSP
//
//  Created by YanaSychevska on 09.03.24.
//

import Foundation

class StockDetailsWrapper: Codable {
    let results: StockDetails
}

class StockDetails: Codable {
    let name: String
    let description: String?
    
    init(name: String, 
         description: String? = nil) {
        self.name = name
        self.description = description
    }
}
