//
//  Change.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 04/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

class ChangeCurrency {
    var delegate: ChangeDelegate?
    var currencyToConvert = ""
    var currencyConverted = ""

    private var toConvert: [String] = []

    /// Convert money one on money two
    func changeCurrency(toConvert: String, currencyOne: String, currencyTwo: String) {
        self.toConvert.append(toConvert)

        currencyToConvert = self.toConvert.joined()

        currencyConverted = calculToConvert(currencyToConvert: currencyToConvert, currencyOne: currencyOne, currencyTwo: currencyTwo)

        delegate?.displayCurrencies()
    }

    private func calculToConvert(currencyToConvert: String, currencyOne: String, currencyTwo: String) -> String {
        // euro = base of calcul
        guard let baseCurrency: Double = CurrencyStorage.currencies[currencyOne] else { return ""  }

        // destination money
        guard let change: Double = CurrencyStorage.currencies[currencyTwo] else {  return ""  }

        // sum to convert in money two
        guard let currencyToConvert = Double(currencyToConvert) else { return ""  }

        let total = currencyToConvert / baseCurrency * change

        let currencyConverted = String(format: "%.2f", total)

        return currencyConverted
    }

    func clear() {
        toConvert.removeAll()
    }
}
