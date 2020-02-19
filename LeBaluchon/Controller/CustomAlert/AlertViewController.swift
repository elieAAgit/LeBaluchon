//
//  AlertViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 18/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    // MARK: - Outlets and Prpoerties
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var alertTitle = String()
    var alertBody = String()
    var alertAction = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cornerRadius()
        setupView()
    }
}

// MARK: - Prepare loading alert: datas and appearance
extension AlertViewController {
    /// Added corner radius to the alert and the action button
    private func cornerRadius() {
        alertView.layer.cornerRadius = 15
        titleView.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        actionButton.layer.cornerRadius = 5
    }

    /// Added the title, the body text and the title button to the alert
    private func setupView() {
        titleLabel.text = alertTitle
        bodyLabel.text = alertBody
        actionButton.setTitle(alertAction, for: .normal)
    }
}

// MARK: - User Action
extension AlertViewController {
    /// Dismiss alert with button action is tapped
    @IBAction func didTapAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
