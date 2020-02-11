//
//  ChangeViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 30/01/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {
    var change = Change()

    @IBOutlet weak var currencyToConvert: UILabel!
    @IBOutlet weak var currencyConverted: UILabel!
    @IBOutlet weak var currencyOne: UIButton!
    @IBOutlet weak var currencyTwo: UIButton!
    
    var source = ""
    var target = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        change.delegate = self

        currencyChange()
    }

    override func viewDidAppear(_ animated: Bool) {
        moneyChoice()
    }
}

// MARK: - Currency
extension ChangeViewController {
    private func currencyChange() {
        ApiService.shared.getApiResponse(apiUrl: .currencyUrl) { (success, nil) in
            if !success {
                // Alert
            }
        }
    }

    private func moneyChoice() {
        source = currencyOne.title(for: .normal) ?? "EUR"
        target = currencyTwo.title(for: .normal) ?? "USD"
    }
}

// MARK: - User actions
extension ChangeViewController {
    @IBAction func tappedNumberButtons(_ sender: UIButton) {
        sender.animated()

        guard let toConvert = sender.currentTitle else {  return }

        change.changeCurrency(toConvert: toConvert, currencyOne: source, currencyTwo: target)
    }

    @IBAction func swap(_ sender: UIButton) {
            sender.animated()
            
            let toConvert: String!

            if source == currencyOne.title(for: .normal) && target == currencyTwo.title(for: .normal) {
                toConvert = currencyConverted.text

                currencyOne.setTitle(target, for: .normal)
                currencyTwo.setTitle(source, for: .normal)
                } else {
                toConvert = currencyToConvert.text

                currencyOne.setTitle(source, for: .normal)
                currencyTwo.setTitle(target, for: .normal)
            }

            source = currencyOne.currentTitle!
            target = currencyTwo.currentTitle!

            clearAll()
            change.changeCurrency(toConvert: toConvert, currencyOne: source, currencyTwo: target)
            change.clear()
    }

    @IBAction func clear(_ sender: UIButton) {
        sender.animated()

        clearAll()
    }

    func clearAll() {
        change.clear()

        currencyToConvert.text = "0"
        currencyConverted.text = "0"
    }
}

// MARK: - Display currencies in View
extension ChangeViewController: ChangeDelegate {
    func displayCurrencies() {
        self.currencyToConvert.text = change.currencyToConvert
        self.currencyConverted.text = change.currencyConverted
    }
}
