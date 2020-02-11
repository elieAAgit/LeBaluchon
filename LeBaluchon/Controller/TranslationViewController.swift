//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 01/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    var language = LanguageService()

    // properties use for translation and swap
    var source = ""
    var target = ""

    @IBOutlet weak var languageToTranslate: UIButton!
    @IBOutlet weak var translatedLanguage: UIButton!
    @IBOutlet weak var languageToTranslateTtextField: UITextField!
    @IBOutlet weak var languageTraductedTextView: UITextView!
    
    @IBOutlet weak var translationMainStackView: UIStackView!
    @IBOutlet weak var topMainStackConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomMainStackConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingLanguages()

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

    override func viewWillAppear(_ animated: Bool) {
        currencyChoice()
    }
}

extension TranslationViewController {
    private func loadingLanguages() {
        ApiService.shared.getApiResponse(apiUrl: .languagesUrl) { (success, nil) in
            if !success {
                // Alert
            }
        }
    }

    private func currencyChoice() {
        source = languageToTranslate.title(for: .normal) ?? "Français"
        target = translatedLanguage.title(for: .normal) ?? "Anglais"
    }
}

// MARK: - Keyboard control
extension TranslationViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        translate()
    }

    private func translate() {
        guard let languageForTraduct = languageToTranslateTtextField.text else {  return }

        language.translate(source: source, target: target, text: languageForTraduct)

        ApiService.shared.getApiResponse(apiUrl: .translateUrl) { (success, translate) in
            if success, let translate = translate as? Translate {
                self.languageTraductedTextView.text = translate.data.translations[0].translatedText
            } else {
                // Alert
            }
        }
    }

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

// MARK: - Swap and clear actions
extension TranslationViewController {
    @IBAction func swap(_ sender: UIButton) {
        let translatedtextStorage = languageTraductedTextView.text

        if source == languageToTranslate.title(for: .normal) && target == translatedLanguage.title(for: .normal) {
            languageToTranslate.setTitle(target, for: .normal)
            translatedLanguage.setTitle(source, for: .normal)
            
        } else {
            languageToTranslate.setTitle(source, for: .normal)
            translatedLanguage.setTitle(target, for: .normal)
        }

        source = languageToTranslate.currentTitle!
        target = translatedLanguage.currentTitle!

        languageToTranslateTtextField.text = translatedtextStorage

        translate()
    }

    @IBAction func clear(_ sender: UIButton) {
        sender.animated()

        clearAllTextField()
    }

    private func clearAllTextField() {
        languageToTranslateTtextField.text = ""
        languageTraductedTextView.text = ""
    }
}
