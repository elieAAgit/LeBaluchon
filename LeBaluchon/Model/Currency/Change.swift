//
//  Change.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 04/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

class Change {
    // Creating property delegation
    var delegate: ChangeDelegate?
    // Properties
    var currencyToConvert = ""
    var currencyConverted = ""

    /// Array to store the value to convert
    private var toConvert: [String] = []

    /// Convert money one on money two
    func changeCurrency(toConvert: String, source: String, target: String) {
        self.toConvert.append(toConvert)

        guard let currencyOne = CurrencyStorage.currenciesList[source] else { return }
        guard let currencyTwo = CurrencyStorage.currenciesList[target] else { return }

        // Merge the array into a single value
        currencyToConvert = self.toConvert.joined()

        // Calcul
        currencyConverted = calculToConvert(currencyToConvert: currencyToConvert, currencyOne: currencyOne, currencyTwo: currencyTwo)

        // Display values
        delegate?.displayCurrencies()
    }

    /// Calcul conversion
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

    /// Empty array
    func clear() {
        toConvert.removeAll()
    }
}
