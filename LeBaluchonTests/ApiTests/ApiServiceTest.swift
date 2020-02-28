//
//  ApiServiceTest.swift
//  LeBaluchonTests
//
//  Created by Elie Arquier on 25/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class ApiServiceTest: XCTestCase {
// MARK: - Generic tests functions
    private func testGetApiResponseShouldPostFailedCallbackIfIncorrectResponse(apiUrl: ApiUrl, data: Data?) {
        // Given
        let apiService = ApiService(
            session: URLSessionFake(data: data, response: FakeResponseData.responseFail, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
       apiService.getApiResponse(apiUrl: apiUrl) { (success, nil) in
            // Then
            XCTAssertFalse(success)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    private func testGetApiResponseShouldPostFailedCallbackIfIncorrectData(apiUrl: ApiUrl) {
         // Given
         let apiService = ApiService(
             session: URLSessionFake(data: FakeResponseData.errorData, response: FakeResponseData.responseOk, error: nil))

         // When
         let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiService.getApiResponse(apiUrl: apiUrl) { (success, nil) in
             // Then
             XCTAssertFalse(success)
             expectation.fulfill()
         }

         wait(for: [expectation], timeout: 0.01)
    }
    
    private func testGetApiResponseShouldPostSuccessCallbackIfNoErrorAndCorrectData(apiUrl: ApiUrl, data: Data?) {
        // Given
        let apiService = ApiService(
            session: URLSessionFake(data: data, response: FakeResponseData.responseOk, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiService.getApiResponse(apiUrl: apiUrl) { (success, nil) in
            // Then
            XCTAssertTrue(success)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}

// MARK: - Testing network calls
extension ApiServiceTest {
// MARK: - General failure tests
    func testGetApiResponseShouldPostFailedCallbackIfError() {
        // Given
        let apiService = ApiService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
       apiService.getApiResponse(apiUrl: .currencyUrl) { (success, nil) in
            // Then
            XCTAssertFalse(success)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetApiResponseShouldPostFailedCallbackIfNoData() {
        // Given
        let apiService = ApiService(
            session: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
       apiService.getApiResponse(apiUrl: .currencyUrl) { (success, nil) in
            // Then
            XCTAssertFalse(success)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

// MARK: - Translate: translateUrl
    func testGetApiResponseTranslateUrl() {
        let apiUrl: ApiUrl = .translateUrl
        let data: Data? = FakeResponseData.googleTranslateUrlCorrectData

        testGetApiResponseShouldPostFailedCallbackIfIncorrectResponse(apiUrl: apiUrl, data: data)

        testGetApiResponseShouldPostFailedCallbackIfIncorrectData(apiUrl: apiUrl)

        testGetApiResponseShouldPostSuccessCallbackIfNoErrorAndCorrectData(apiUrl: apiUrl, data: data)
    }

// MARK: - Languages: LanguagesUrl
    func testGetApiResponseLanguagesUrl() {
        let apiUrl: ApiUrl = .languagesUrl
        let data: Data? = FakeResponseData.googleLanguagesUrlCorrectData

        testGetApiResponseShouldPostFailedCallbackIfIncorrectResponse(apiUrl: apiUrl, data: data)

        testGetApiResponseShouldPostFailedCallbackIfIncorrectData(apiUrl: apiUrl)

        testGetApiResponseShouldPostSuccessCallbackIfNoErrorAndCorrectData(apiUrl: apiUrl, data: data)
    }

// MARK: - Exchange rates: currencyUrl
    func testGetApiResponseCurrencyUrl() {
        let apiUrl: ApiUrl = .currencyUrl
        let data: Data? = FakeResponseData.fixerCurrencyUrlCorrectData

        testGetApiResponseShouldPostFailedCallbackIfIncorrectResponse(apiUrl: apiUrl, data: data)

        testGetApiResponseShouldPostFailedCallbackIfIncorrectData(apiUrl: apiUrl)

        testGetApiResponseShouldPostSuccessCallbackIfNoErrorAndCorrectData(apiUrl: apiUrl, data: data)
    }

// MARK: - Currencies list: currencyListUrl
    func testGetApiResponseCurrencyListUrl() {
        let apiUrl: ApiUrl = .currencyListUrl
        let data: Data? = FakeResponseData.fixerCurrencyListUrlCorrectData

        testGetApiResponseShouldPostFailedCallbackIfIncorrectResponse(apiUrl: apiUrl, data: data)

        testGetApiResponseShouldPostFailedCallbackIfIncorrectData(apiUrl: apiUrl)

        testGetApiResponseShouldPostSuccessCallbackIfNoErrorAndCorrectData(apiUrl: apiUrl, data: data)
    }

    // MARK: - OpenWeather single id: weatherSingleIdUrl
    func testGetApiResponseWeatherSingleIdUrl() {
        let apiUrl: ApiUrl = .weatherSingleIdUrl
        let data: Data? = FakeResponseData.weatherSingleIdUrlCorrectData

        testGetApiResponseShouldPostFailedCallbackIfIncorrectResponse(apiUrl: apiUrl, data: data)

        testGetApiResponseShouldPostFailedCallbackIfIncorrectData(apiUrl: apiUrl)

        testGetApiResponseShouldPostSuccessCallbackIfNoErrorAndCorrectData(apiUrl: apiUrl, data: data)
    }

// MARK: - OpenWeather Multiple cities calls: weatherMultipleIdUrl
    func testGetApiResponseWeatherMultipleIdUrl() {
        let apiUrl: ApiUrl = .weatherMultipleIdUrl
        let data: Data? = FakeResponseData.weatherMultipleIdCorrectData

        testGetApiResponseShouldPostFailedCallbackIfIncorrectResponse(apiUrl: apiUrl, data: data)

        testGetApiResponseShouldPostFailedCallbackIfIncorrectData(apiUrl: apiUrl)

        testGetApiResponseShouldPostSuccessCallbackIfNoErrorAndCorrectData(apiUrl: apiUrl, data: data)
    }

// MARK: - OpenWeather: weatherForecastUrl
    func testGetApiResponseWeatherForecastUrl() {
        let apiUrl: ApiUrl = .weatherForecastUrl
        let data: Data? = FakeResponseData.weatherForecastUrlCorrectData

        testGetApiResponseShouldPostFailedCallbackIfIncorrectResponse(apiUrl: apiUrl, data: data)

        testGetApiResponseShouldPostFailedCallbackIfIncorrectData(apiUrl: apiUrl)

        testGetApiResponseShouldPostSuccessCallbackIfNoErrorAndCorrectData(apiUrl: apiUrl, data: data)
    }

// MARK: - Geodb cities list: citiesListUrl
    func testGetApiResponseCitiesListUrl() {
        let apiUrl: ApiUrl = .citiesListUrl
        let data: Data? = FakeResponseData.citiesListUrlCorrectData

        testGetApiResponseShouldPostFailedCallbackIfIncorrectResponse(apiUrl: apiUrl, data: data)

        testGetApiResponseShouldPostFailedCallbackIfIncorrectData(apiUrl: apiUrl)

        testGetApiResponseShouldPostSuccessCallbackIfNoErrorAndCorrectData(apiUrl: apiUrl, data: data)
    }
}
