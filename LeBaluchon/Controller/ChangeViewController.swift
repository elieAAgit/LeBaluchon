//
//  ChangeViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 30/01/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {
    var changeCurrency = ChangeCurrency()

    @IBOutlet weak var currencyToConvert: UILabel!
    @IBOutlet weak var currencyConverted: UILabel!
    @IBOutlet weak var currencyOne: UIButton!
    @IBOutlet weak var currencyTwo: UIButton!
    
    var moneyOne = ""
    var moneyTwo = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        changeCurrency.delegate = self

        currencyChange()
    }

    override func viewDidAppear(_ animated: Bool) {
        moneyChoice()
    }
}

// MARK: - Currency
extension ChangeViewController {
    private func currencyChange() {
        CurrencyService.shared.getCurrency { (succes) in
            if !succes {
                // Alert
            }
        }
    }

    private func moneyChoice() {
        moneyOne = currencyOne.title(for: .normal) ?? "EUR"
        moneyTwo = currencyTwo.title(for: .normal) ?? "USD"
    }
}

// MARK: - User actions
extension ChangeViewController {
    @IBAction func tappedNumberButtons(_ sender: UIButton) {
        sender.animated()

        guard let toConvert = sender.currentTitle else {  return }

        changeCurrency.changeCurrency(toConvert: toConvert, currencyOne: moneyOne, currencyTwo: moneyTwo)
    }

    @IBAction func clear(_ sender: UIButton) {
        sender.animated()

        clearAll()
    }

    func clearAll() {
        changeCurrency.clear()

        currencyToConvert.text = "0"
        currencyConverted.text = "0"
    }
}

// MARK: - Display currencies in View
extension ChangeViewController: ChangeDelegate {
    func displayCurrencies() {
        self.currencyToConvert.text = changeCurrency.currencyToConvert
        self.currencyConverted.text = changeCurrency.currencyConverted
    }
}
