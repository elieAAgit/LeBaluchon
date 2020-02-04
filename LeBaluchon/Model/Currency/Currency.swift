//
//  Currency.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 02/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

/// Decoding structure of the response Json file.
struct  Currency: Decodable {
    var rates: [String: Double]
}
