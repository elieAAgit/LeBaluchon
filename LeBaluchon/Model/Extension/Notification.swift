//
//  Notification.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 18/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

extension Notification {
    /// Cases of alerts
    enum Alert {
        case errorData, languageUnknown, languagesList, currenciesRates, currenciesList,
        currencyUnknown, citiesDisplay, inputError
    }

    /// To sent an alert
    static func alertPost(alert: Alert) {
        NotificationCenter.default.post(name: .alertName, object: nil, userInfo: ["Alert": alert])
    }
}
