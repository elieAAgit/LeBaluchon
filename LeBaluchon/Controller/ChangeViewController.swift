//
//  ChangeViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 30/01/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {
    // MARK: - Outlets and properties
    @IBOutlet weak var currencyToConvert: UILabel!
    @IBOutlet weak var currencyConverted: UILabel!
    @IBOutlet weak var currencyOne: UIButton!
    @IBOutlet weak var currencyTwo: UIButton!

    // Change class object
    var change = Change()

    // Properties to pass data between controller
    var segueOrigin: SegueIdentifier = .changeToList
    var identifier: Identifier?
    var passData: String?

    // Properties necessary to carry out the swap
    var source = ""
    var target = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        change.delegate = self

        LoadingCurrencies()
    }

    override func viewDidAppear(_ animated: Bool) {
        currencyChoice()
    }

    /// Segue to come back to ChangeViewController
    @IBAction func unwindtoChangeViewController(segue: UIStoryboardSegue) {
    }
}

// MARK: - Currency
extension ChangeViewController {
    /// Makes the two necessary network calls and initializes currencies
    private func LoadingCurrencies() {
            // Exchange rates network call
            ApiService.shared.getApiResponse(apiUrl: .currencyUrl) { (success, nil) in
                if success && CurrencyStorage.currenciesKeys.isEmpty {
                    // Currencies name network call
                    ApiService.shared.getApiResponse(apiUrl: .currencyListUrl) { (success, nil) in
                        if !success {
                            // Alert
                        }
                    }
                } else {
                    // Alert
                }
            }

        // Initialization of currencies
        currencyOne.setTitle(UserPreferences.currencyOne, for: .normal)
        currencyTwo.setTitle(UserPreferences.currencyTwo, for: .normal)
    }

    /// Display currency chose on TableView
    private func currencyChoice() {
        // passData none nil: if passData is nil, display will be empty
        if identifier == .currencyOne && passData != nil {
            currencyOne.setTitle(passData, for: .normal)
        } else if identifier == .currencyTwo && passData != nil {
            currencyTwo.setTitle(passData, for: .normal)
        }

        // Values ​​to swap (and currency conversion)
        source = currencyOne.currentTitle!
        target = currencyTwo.currentTitle!

        // Clean properties and outlets to pass data between controller
        identifier = nil
        passData = nil
        clearAll()
    }
}

// MARK: - User actions
extension ChangeViewController {
    /// A currency conversion is executed each time the source currency is changed
    @IBAction func tappedNumberButtons(_ sender: UIButton) {
        sender.animated()

        guard let toConvert = sender.currentTitle else {  return }

        // Execute conversion
        change.changeCurrency(toConvert: toConvert, source: source, target: target)
    }

    /// Swapping currency one and currency two
    @IBAction func swap(_ sender: UIButton) {
        sender.animated()
        
        let toConvert: String!

        // Swap
        if source == currencyOne.title(for: .normal) && target == currencyTwo.title(for: .normal) {
            toConvert = currencyConverted.text

            currencyOne.setTitle(target, for: .normal)
            currencyTwo.setTitle(source, for: .normal)
            } else {
            toConvert = currencyToConvert.text

            currencyOne.setTitle(source, for: .normal)
            currencyTwo.setTitle(target, for: .normal)
        }

        // Values to swap (and currency conversion)
        source = currencyOne.currentTitle!
        target = currencyTwo.currentTitle!

        // Clear all before swapping
        clearAll()
        // Execute conversion
        change.changeCurrency(toConvert: toConvert, source: source, target: target)
        // Clear change property storage
        change.clear()
    }

    /// Clear textFeld, textView and change property storage
    @IBAction func clear(_ sender: UIButton) {
        sender.animated()

        clearAll()
    }

    /// Clear textFeld, textView and change property storage
    func clearAll() {
        change.clear()

        currencyToConvert.text = "0"
        currencyConverted.text = "0"
    }
}

// MARK: - Display currencies in View
extension ChangeViewController: ChangeDelegate {
    /// Display the change result
    func displayCurrencies() {
        self.currencyToConvert.text = change.currencyToConvert
        self.currencyConverted.text = change.currencyConverted
    }
}

// MARK: - Segue to TableViewController
extension ChangeViewController {
    /// Action segue to list
    @IBAction func toList(_ sender: UIButton) {
        changeList(sender: sender)

        performSegue(withIdentifier: SegueIdentifier.changeToList.rawValue, sender: self)
    }

    /// Identify which currency is the source of the action
    private func changeList(sender: UIButton) {
        // tag 4 = source currency, tag 5 = target currency
        if sender.tag == 4 {
            identifier = .currencyOne
        } else if sender.tag == 5 {
            identifier = .currencyTwo
        }
    }

    /// Pass identifier to the next controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.changeToList.rawValue {
            let tableViewController = segue.destination as! TableViewController
            tableViewController.identifier = identifier
            tableViewController.segueOrigin = segueOrigin
        } else {
            // Alert
        }
    }
}
