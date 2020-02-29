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
    case translateUrl, languagesUrl, currencyUrl, currencyListUrl, weatherSingleIdUrl, weatherMultipleIdUrl,
    weatherForecastUrl, citiesListUrl
}

//MARK: - Translation
struct ApiKeys {
    static private let translateBase = "https://translation.googleapis.com/language/translate/v2"
    static private let languagesList = "/languages"
    static private let translatekey = valueForAPIKey(named:"TranslateKey")
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
    static private let currencyKey = valueForAPIKey(named:"CurrencyKey")

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
    static private let weatherKey = valueForAPIKey(named:"WeatherKey")
    static private let weatherLanguage = "&lang=fr"
    static private let unit = "&units=metric"
    static var weatherSingleId = "weather?"
    static private let weatherPrevision = "forecast?"
    static var weatherParameters = "lat=&lon="
    // 
    static var weatherMultipleIdParameters = "group?id=\(UserPreferences.cityOneId),\(UserPreferences.cityTwoId)"

    // Single city calls
    static var weatherSingleIdUrl: String {
        return weatherBase + weatherSingleId + weatherParameters + weatherKey + weatherLanguage + unit
    }

    // Multiple cities calls
    static var weatherMultipleIdUrl: String {
        return weatherBase + weatherMultipleIdParameters + weatherKey + weatherLanguage + unit
    }

    // Five days previsions
    static var weatherForecastUrl: String {
        return weatherBase + weatherPrevision + weatherParameters + weatherKey + weatherLanguage + unit
    }
}

// MARK: - World cities list
extension ApiKeys {
    //geodb-cities-api
    static private let citiesWeatherBase = "http://geodb-free-service.wirefreethought.com/v1/"
    static private let citiesWeatherSearch = "geo/cities?limit=5&offset=0"
    static var citiesWeatherParameters = "&namePrefix="
    static private let citiesWeatherLanguage = "&languageCode=fr"
    //
    static var citiesListUrl: String {
        return citiesWeatherBase + citiesWeatherSearch + citiesWeatherParameters + citiesWeatherLanguage
    }
}
