//
//  LanguageServiceTests.swift
//  LeBaluchonTests
//
//  Created by Elie Arquier on 28/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class LanguageServiceTests: XCTestCase {
// MARK: - Prepare Tests
    var language: LanguageService!

    override func setUp() {
        language = LanguageService()
        LanguageStorage.languageValue = LanguageStorageTest.languageValueTest
        ApiKeys.parameters = ""
    }
}

// MARK: - Tests
extension LanguageServiceTests {
    func testGivenWantTranslateText_WhenAlreaadyIsOk_ThenTranslationIsSuccess() {
        let source = "Français"
        let target = "Anglais"
        let text = "Bonjour"

        language.translate(source: source, target: target, text: text)

        XCTAssertEqual(ApiKeys.parameters, "&source=fr&target=en&q=Bonjour")
    }

    func testGivenWantTranslateText_WhenCurrencySourceIsUnknown_ThenTranslationFailed() {
        // Language source unknown
        let source = "Test"
        let target = "Anglais"
        let text = "Bonjour"

        language.translate(source: source, target: target, text: text)

        XCTAssertEqual(ApiKeys.parameters, "")
    }
    
    func testGivenWantTranslateText_WhenCurrencyTargetIsUnknown_ThenTranslationFailed() {
        let source = "Français"
        // Language target unknown
        let target = "Test"
        let text = "Bonjour"

        language.translate(source: source, target: target, text: text)

        XCTAssertEqual(ApiKeys.parameters, "")
    }
}
