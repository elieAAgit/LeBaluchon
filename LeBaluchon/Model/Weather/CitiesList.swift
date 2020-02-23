//
//  CitiesList.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 21/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

struct CitiesList: Decodable {
    let data: [List]
    let metadata: Metadata
}

struct List: Decodable {
    let id: Int
    let wikiDataId: String
    let type: String
    let city: String
    let name: String
    let country: String
    let countryCode: String
    let region: String
    let regionCode: String
    let latitude: Double
    let longitude: Double
}

struct Metadata: Decodable {
    let currentOffset: Int
    let totalCount: Int
}
/*
 Exemple Paris, France:
 {
     "data": [
         {
             "id": 144571,
             "wikiDataId": "Q90",
             "type": "CITY",
             "city": "Paris",
             "name": "Paris",
             "country": "France",
             "countryCode": "FR",
             "region": "Île-de-France",
             "regionCode": "IDF",
             "latitude": 48.8534,
             "longitude": 2.3486
         }
     ],
     "metadata": {
         "currentOffset": 0,
         "totalCount": 2
     }
 }
 */
