//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 01/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    @IBOutlet weak var languageToTranslateTtextField: UITextField!
    @IBOutlet weak var languageTraductedTextView: UITextView!
    
    @IBOutlet weak var translationMainStackView: UIStackView!
    @IBOutlet weak var topMainStackConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomMainStackConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        languageToTranslateTtextField.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
}

// MARK: - Keyboard control
extension TranslationViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()

        return true
    }

    private func hideKeyboard() {
        languageToTranslateTtextField.resignFirstResponder()
    }
}

// MARK: - Adaptive view depending on the keyboard
extension TranslationViewController {
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {  return }

        if notification.name == UIResponder.keyboardWillShowNotification ||
           notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height/2

            UIView.animate(withDuration: 0.8) {
                self.topMainStackConstraint.constant = keyboardRect.height/2
                self.bottomMainStackConstraint.constant = keyboardRect.height/2 - 45
                self.translationMainStackView.layoutIfNeeded()
            }
        } else {
            view.frame.origin.y = 0
            
            UIView.animate(withDuration: 0.8) {
                self.topMainStackConstraint.constant = 20
                self.bottomMainStackConstraint.constant = 20
                self.translationMainStackView.layoutIfNeeded()
            }
        }
    }
}
