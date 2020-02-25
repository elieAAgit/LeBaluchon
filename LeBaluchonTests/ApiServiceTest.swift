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

    func testGetApiResponseShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let apiService = ApiService(
            session: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseFail, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
       apiService.getApiResponse(apiUrl: .currencyUrl) { (success, nil) in
            // Then
            XCTAssertFalse(success)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetApiResponseShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let apiService = ApiService(
            session: URLSessionFake(data: FakeResponseData.fixerErrorData, response: FakeResponseData.responseOk, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
       apiService.getApiResponse(apiUrl: .currencyUrl) { (success, nil) in
            // Then
            XCTAssertFalse(success)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetApiResponseShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let apiService = ApiService(
            session: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseOk, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
       apiService.getApiResponse(apiUrl: .currencyUrl) { (success, nil) in
            // Then
            XCTAssertTrue(success)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

}
