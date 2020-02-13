//
//  CurrencyDecodable.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 13/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

/// Decoding structure of the response Json file: exchange rates network call
struct  Currency: Decodable {
    var rates: [String: Double]
}

/// Decoding structure of the response Json file: currencies name network call
struct CurrencyList: Decodable {
    var symbols: [String: String]
}
