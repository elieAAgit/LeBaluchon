//
//  ApiService.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 08/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

class ApiService {
    // Singleton pattern
    static var shared = ApiService()
    private init() {}

    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)

    init(session: URLSession) {
        self.session = session
    }

    //API request
    func getApiResponse(apiUrl: ApiUrl, callback: @escaping (Bool, Any?) -> Void) {
        let UrlChoice = apiChoice(apiUrl: apiUrl)
        let request = getRequest(UrlChoice: UrlChoice, apiUrl: apiUrl)
        
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil  else {
                    callback(false, nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                self.responseJsonResolution(apiUrl: apiUrl, response: response, callback: callback, data: data)
            }
        }
        
        task?.resume()
    }

    ///Choice of service call
    private func apiChoice(apiUrl: ApiUrl) -> String {
        var apiChoice = String()

        switch apiUrl {
            case .currencyUrl:
                apiChoice = ApiKeys.currencyUrl
            case .currencyListUrl:
                apiChoice = ApiKeys.currencyListUrl
            case .translateUrl:
                apiChoice = ApiKeys.translateUrl
            case .languagesUrl:
                apiChoice = ApiKeys.languagesUrl
            case .weatherSingleIdUrl:
                apiChoice = ApiKeys.weatherSingleIdUrl
            case .weatherMultipleIdUrl:
                apiChoice = ApiKeys.weatherMultipleIdUrl
            case .weatherForecastUrl:
                apiChoice = ApiKeys.weatherForecastUrl
            case .citiesListUrl:
                apiChoice = ApiKeys.citiesListUrl
        }

        return apiChoice
    }

    ///Choice of method
    private func getRequest(UrlChoice: String, apiUrl: ApiUrl) -> URLRequest {
        let requestUrl = URL(string: UrlChoice)!
        var request = URLRequest(url: requestUrl)

        var method: String {
            var assign: String

            switch apiUrl {
            case .translateUrl, .currencyUrl, .currencyListUrl:
                    assign = Method.post.rawValue
            case .languagesUrl, .weatherSingleIdUrl, .weatherMultipleIdUrl, .weatherForecastUrl, .citiesListUrl:
                    assign = Method.get.rawValue
            }
            
            return assign
        }

        request.httpMethod = method

        if UrlChoice == ApiKeys.translateUrl {
            let body = ApiKeys.parameters
            request.httpBody = body.data(using: .utf8)
        }

        return request
    }

    ///Call response
    private func responseJsonResolution(apiUrl: ApiUrl, response: HTTPURLResponse, callback: @escaping (Bool, Any?) -> Void, data: Data) {
        //Translate
        if apiUrl == ApiUrl.translateUrl {
            guard let responseJSON = try? JSONDecoder().decode(Translate.self, from: data) else {
                callback(false, nil)
                return
            }

            callback(true, responseJSON)
        //Language list
        } else if apiUrl == ApiUrl.languagesUrl {
            guard let responseJSON = try? JSONDecoder().decode(Language.self, from: data) else {
                callback(false, nil)
                return
            }

            for key in 0 ..< responseJSON.data.languages.count {
                LanguageStorage.languageKey.append(responseJSON.data.languages[key].name)
                LanguageStorage.languageValue[responseJSON.data.languages[key].name] = responseJSON.data.languages[key].language
            }
            
            callback(true, nil)
        //Currency
        } else if apiUrl == ApiUrl.currencyUrl {
            guard let responseJSON = try? JSONDecoder().decode(Currency.self, from: data) else {
                callback(false, nil)
                return
            }

            CurrencyStorage.currencies = responseJSON.rates
            callback(true, nil)
        //Currency list
        } else if apiUrl == ApiUrl.currencyListUrl {
            guard let responseJSON = try? JSONDecoder().decode(CurrencyList.self, from: data) else {
                callback(false, nil)
                return
            }

            for (key, value) in Array(responseJSON.symbols.sorted(by: {$0.0 < $1.0})) {
                CurrencyStorage.currenciesKeys.append(value)
                //
                CurrencyStorage.currenciesList[value] = key
            }
            callback(true, nil)
        //New city
        } else if apiUrl == ApiUrl.weatherSingleIdUrl {
            guard let responseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {                callback(false, nil)
                return
            }

            callback(true, responseJSON)
        //Loading cities
        } else if apiUrl == ApiUrl.weatherMultipleIdUrl {
            guard let responseJSON = try? JSONDecoder().decode(WeatherMultiple.self, from: data) else {
                callback(false, nil)
                return
            }

            callback(true, responseJSON)
        //Detail weather
        } else if apiUrl == ApiUrl.weatherForecastUrl {
            guard let responseJSON = try? JSONDecoder().decode(WeatherForecast.self, from: data) else {
                callback(false, nil)
                return
            }

            callback(true, responseJSON)
        //Choice of city
        } else if apiUrl == ApiUrl.citiesListUrl {
            guard let responseJSON = try? JSONDecoder().decode(CitiesList.self, from: data) else {
                callback(false, nil)
                return
            }

            callback(true, responseJSON)
        }
    }
}
