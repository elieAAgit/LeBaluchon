//
//  LanguageService.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 06/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

class LanguageService {
    static var shared = LanguageService()
    private init() {}

    private let base = "https://translation.googleapis.com/language/translate/v2"
    private let languagesList = "/languages"
    private let key = "?key=AIzaSyDFDr4OL45OEAg0Wabd4X9QD7-hFwbUTJ0"
    private let target = "&target=fr"
    private var parameters = ""

    func translate(source: String, target: String, text: String) {
        parameters = "&source=\(source)&target=\(target)&q=\(text)"
    }

    private var task: URLSessionDataTask?

    func getTranslate(callback: @escaping (Bool, Translate?) -> Void) {
        let request = createTranslateRequest()
        let session = URLSession(configuration: .default)

        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                guard let responseJSON = try? JSONDecoder().decode(Translate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
                
            }
        }

        task?.resume()
    }

    private func createTranslateRequest() -> URLRequest {
        let translateUrl = URL(string: base + key)!
        var request = URLRequest(url: translateUrl)
        request.httpMethod = "POST"

        let body = parameters
        request.httpBody = body.data(using: .utf8)

        return request
    }
}

extension LanguageService {
    func getLanguage(callback: @escaping (Bool) -> Void) {
        let request = createLanguageRequest()
        let session = URLSession(configuration: .default)

        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false)
                    return
                }

                guard let responseJSON = try? JSONDecoder().decode(Language.self, from: data) else {
                    callback(false)
                    return
                }
                callback(true)

                for key in 0 ..< responseJSON.data.languages.count {
                    LanguageStorage.languageKey.append(responseJSON.data.languages[key].name)
                    LanguageStorage.languageValue[responseJSON.data.languages[key].name] = responseJSON.data.languages[key].language
                }
            }
        }

        task?.resume()
    }

    private func createLanguageRequest() -> URLRequest {
        let translateUrl = URL(string: base + languagesList + key + target)!
        var request = URLRequest(url: translateUrl)
        request.httpMethod = "GET"

        return request
    }
}
