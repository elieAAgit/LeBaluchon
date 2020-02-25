//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by Elie Arquier on 24/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

class FakeResponseData {
    static let responseOk = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseFail = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class FixerError: Error {}
    static let error = FixerError()

    static var googleTranslateUrlCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "GoogleTranslate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
    
        return data
    }

    static var googleLanguagesUrlCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "GoogleLanguages", withExtension: "json")
        let data = try! Data(contentsOf: url!)
    
        return data
    }

    static var fixerCurrencyUrlCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "FixerExchange", withExtension: "json")
        let data = try! Data(contentsOf: url!)
    
        return data
    }

    static var fixerCurrencyListUrlCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "FixerList", withExtension: "json")
        let data = try! Data(contentsOf: url!)
    
        return data
    }

    static var weatherSingleIdUrlCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "WeatherSingleIdUrl", withExtension: "json")
        let data = try! Data(contentsOf: url!)
    
        return data
    }

    static var weatherMultipleIdCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "WeatherMultipleId", withExtension: "json")
        let data = try! Data(contentsOf: url!)
    
        return data
    }

    static var weatherForecastUrlCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "WeatherForecastUrl", withExtension: "json")
        let data = try! Data(contentsOf: url!)
    
        return data
    }

    static var citiesListUrlCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "GeodbApi", withExtension: "json")
        let data = try! Data(contentsOf: url!)
    
        return data
    }

    static let errorData = "error".data(using: .utf8)!
}
