//
//  AlertService.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 18/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class AlertService {
    /// Creating alert with title, body and title button for each specific case of alerts
    static func alert(title: String, body: String, buttonTitle: String) -> AlertViewController {
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        guard let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as? AlertViewController else { return AlertViewController() }

        alertVC.alertTitle = title
        alertVC.alertBody = body
        alertVC.alertAction = buttonTitle

        return alertVC
    }
}
