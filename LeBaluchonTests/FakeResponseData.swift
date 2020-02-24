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

    static var fixerCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "FixerTests", withExtension: "json")
        let data = try! Data(contentsOf: url!)
    
        return data
    }

    static let fixerErrorData = "error".data(using: .utf8)!
}
