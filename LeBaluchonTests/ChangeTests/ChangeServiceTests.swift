//
//  ChangeServiceTests.swift
//  LeBaluchonTests
//
//  Created by Elie Arquier on 27/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class ChangeServiceTests: XCTestCase {
// MARK: - Prepare Tests
    var change: ChangeService!

    override func setUp() {
        change = ChangeService()
        storage()
    }

    private func storage() {
        CurrencyStorage.currenciesKeys = CurrencyTest.currenciesKeysTest
        CurrencyStorage.currenciesList = CurrencyTest.currenciesListTest
        CurrencyStorage.currencies = CurrencyTest.currenciesTest
    }
}

// MARK: - Tests
extension ChangeServiceTests {
    func testGivenWantChangeMoney_WhenAlreaadyIsOk_ThenChangeIsSuccess() {
        let currencyOne = "Euro"
        let currencyTwo = "United States Dollar"

        // USD = 1.09915
        change.changeCurrency(toConvert: "10", source: currencyOne, target: currencyTwo)

        XCTAssertEqual(change.currencyToConvert, "10")
        XCTAssertEqual(change.currencyConverted, "10.99")
    }

    func testGivenWantChangeMoney_WhenCurrencySourceIsUnknown_ThenChangeFailed() {
        let currencyOne = "test"
        let currencyTwo = "United States Dollar"

        change.changeCurrency(toConvert: "10", source: currencyOne, target: currencyTwo)

        XCTAssertEqual(change.currencyToConvert, "")
        XCTAssertEqual(change.currencyConverted, "")
    }
    
    func testGivenWantChangeMoney_WhenCurrencyTargetIsUnknown_ThenChangeFailed() {
        let currencyOne = "Euro"
        let currencyTwo = "test"

        change.changeCurrency(toConvert: "10", source: currencyOne, target: currencyTwo)

        XCTAssertEqual(change.currencyToConvert, "")
        XCTAssertEqual(change.currencyConverted, "")
    }

    func testGivenWantChangeMoney_WhenCurrencyOneExistsButChangeMissing_ThenChangeFailed() {
        // Japanese Yen remove from conversion list
        let currencyOne = "Japanese Yen"
        let currencyTwo = "United States Dollar"

        change.changeCurrency(toConvert: "10", source: currencyOne, target: currencyTwo)

        XCTAssertEqual(change.currencyToConvert, "10")
        XCTAssertEqual(change.currencyConverted, "")
    }

    func testGivenWantChangeMoney_WhenCurrencyTwoExistsButChangeMissing_ThenChangeFailed() {
        let currencyOne = "Euro"
        // Canadian Dollar remove from conversion list
        let currencyTwo = "Canadian Dollar"

        change.changeCurrency(toConvert: "10", source: currencyOne, target: currencyTwo)

        XCTAssertEqual(change.currencyToConvert, "10")
        XCTAssertEqual(change.currencyConverted, "")
    }

    func testGivenWantChangeMoney_WhenToConvertIsNotNumbersOrDot_ThenChangeFailed() {
        let currencyOne = "Euro"
        let currencyTwo = "United States Dollar"

        // Replace numbers by "test"
        change.changeCurrency(toConvert: "test", source: currencyOne, target: currencyTwo)

        XCTAssertEqual(change.currencyToConvert, "test")
        XCTAssertEqual(change.currencyConverted, "")
    }

    func testGivenToConvertIsNotEmpty_WhenMakingClearAction_ThenToConvertIsEmpty() {
        change.toConvert = ["1", "1", "1"]
        change.clear()

        XCTAssertEqual(change.toConvert, [])
    }
}
