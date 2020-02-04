//
//  ChangeViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 30/01/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
}
