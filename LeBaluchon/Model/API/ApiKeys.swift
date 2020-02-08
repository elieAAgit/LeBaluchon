//
//  ApiKeys.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 08/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

enum Method: String {
    case post = "POST"
    case get = "GET"
}

enum ApiUrl {
    case translateUrl, languagesUrl, currencyUrl
}

//MARK: - Translation
struct ApiKeys {
    static private let translateBase = "https://translation.googleapis.com/language/translate/v2"
    static private let languagesList = "/languages"
    static private let translatekey = "?key=AIzaSyDFDr4OL45OEAg0Wabd4X9QD7-hFwbUTJ0"
    static private let languagestarget = "&target=fr"
    static var parameters = ""
    // Translate
    static var translateUrl: String {
        return translateBase + translatekey
    }
    // Languages
    static var languagesUrl: String {
        return translateBase + languagesList + translatekey + languagestarget
    }
}

// MARK: - Change
extension ApiKeys {
    static private let currencyBase = "http://data.fixer.io/api/latest?access_Key="
    static private let currencyKey = "61f7748c51902a6bc510ac6a672ccc46&format=1"
    //
    static var currencyUrl: String {
        return currencyBase + currencyKey
    }
}
