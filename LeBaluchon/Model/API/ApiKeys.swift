//
//  ApiKeys.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 08/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

/// Network Call using POST method or GET method
enum Method: String {
    case post = "POST"
    case get = "GET"
}

/// Different network call cases that can be made
enum ApiUrl {
    case translateUrl, languagesUrl, currencyUrl, currencyListUrl, weatherSingleIdUrl, weatherMultipleIdUrl
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
    static private let currencyBase = "http://data.fixer.io/api/"
    static private let currencyChange = "latest"
    static private let currencySymbols = "symbols"
    static private let currencyKey = "?access_Key=61f7748c51902a6bc510ac6a672ccc46&format=1"

    // Exchange rates
    static var currencyUrl: String {
        return currencyBase + currencyChange + currencyKey
    }
 
    // Currencies list
    static var currencyListUrl: String {
        return currencyBase + currencySymbols + currencyKey
    }
}

// MARK: - Weather
extension ApiKeys {
    static private let weatherBase = "http://api.openweathermap.org/data/2.5/"
    static private let weatherKey = "&APPID="
    static private let weatherLanguage = "&lang=fr"
    static private let unit = "&units=metric"
    static var weatherSingleIdParameters = "weather?id="
    // ?? = Paris, 5128581 = New-York
    static var weatherMultipleIdParameters = "group?id=5128581,5128581"

    // Single city calls
    static var weatherSingleIdUrl: String {
        return weatherBase + weatherSingleIdParameters + weatherKey + weatherLanguage + unit
    }

    // Multiple cities calls
    static var weatherMultipleIdUrl: String {
        return weatherBase + weatherMultipleIdParameters + weatherKey + weatherLanguage + unit
    }
}
