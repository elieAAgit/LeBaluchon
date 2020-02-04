//
//  CurrencyService.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 02/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

class CurrencyService {
    static var shared = CurrencyService()
    private init() {}

    private let currencyUrl = URL(string: "http://data.fixer.io/api/latest?access_Key=61f7748c51902a6bc510ac6a672ccc46&format=1")!
    private var task: URLSessionDataTask?

    private var session = URLSession(configuration: .default)

    init(session: URLSession) {
        self.session = session
    }

    func getCurrency(callback: @escaping (Bool) -> Void) {
        let request = currencyRequest()
        
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil  else {
                    callback(false)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false)
                    return
                }

                guard let responseJSON = try? JSONDecoder().decode(Currency.self, from: data) else {
                    callback(false)
                    return
                }

                for (key, _) in Array(responseJSON.rates.sorted(by: {$0.0 < $1.0})) {
                    CurrencyStorage.currenciesKeys.append(key)
                }

                CurrencyStorage.currencies = responseJSON.rates
                callback(true)
            }
        }
        
        task?.resume()
    }
    
    private func currencyRequest() -> URLRequest {
        var request = URLRequest(url: currencyUrl)
        request.httpMethod = "POST"

        return request
    }
}
