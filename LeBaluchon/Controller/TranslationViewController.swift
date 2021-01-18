//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 01/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    // MARK: - Outlets and properties
    @IBOutlet weak var languageToTranslate: UIButton!
    @IBOutlet weak var translatedLanguage: UIButton!
    @IBOutlet weak var languageToTranslateTextField: UITextField!
    @IBOutlet weak var languageTraductedTextView: UITextView!
    //
    @IBOutlet weak var translationMainStackView: UIStackView!
    @IBOutlet weak var topMainStackConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomMainStackConstraint: NSLayoutConstraint!

    // Language class object
    var language = LanguageService()

    // Properties to pass data between controller
    var segueOrigin: SegueIdentifier = .translationToList
    var identifier: Identifier?
    var passData: String?

    // properties use for translation and swap
    var source = String()
    var target = String()

    var userPreferenceLanguageOne = String()
    var userPreferenceLanguageTwo = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingLanguages()

        languageToTranslateTextField.delegate = self

        /// To display alert if needed
        NotificationCenter.default.addObserver(self, selector: #selector(actionAlert(notification:)), name: .alertName, object: nil)

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
        languageChoice()
    }

    override func viewWillDisappear(_ animated: Bool) {
        hideKeyboard()
    }

    @IBAction func unwindtoTranslationViewController(segue: UIStoryboardSegue) {
    }
}

// MARK: - Translation
extension TranslationViewController {
    ///Network call
    private func loadingLanguages() {
        if LanguageStorage.languageKey.isEmpty {
            ApiService.shared.getApiResponse(apiUrl: .languagesUrl) { (success, nil) in
                if !success {
                    Notification.alertPost(alert: .languagesList)
                }
            }
        }

        languageToTranslate.setTitle(UserPreferences.languageOne, for: .normal)
        translatedLanguage.setTitle(UserPreferences.languageTwo, for: .normal)
    }

    /// Display language chose on TableView
    private func languageChoice() {
        if identifier == .languageOne && passData != nil {
            languageToTranslate.setTitle(passData, for: .normal)
        } else if identifier == .languageTwo && passData != nil {
            translatedLanguage.setTitle(passData, for: .normal)
        }else if userPreferenceLanguageOne != UserPreferences.languageOne {
            languageToTranslate.setTitle(UserPreferences.languageOne, for: .normal)
            userPreferenceLanguageOne = UserPreferences.languageOne
        } else if userPreferenceLanguageTwo != UserPreferences.languageTwo {
            translatedLanguage.setTitle(UserPreferences.languageTwo, for: .normal)
            userPreferenceLanguageTwo = UserPreferences.languageTwo
        }

        // Values ​​to swap 
        source = languageToTranslate.currentTitle!
        target = translatedLanguage.currentTitle!

        // Clean properties and outlets to pass data between controller
        identifier = nil
        passData = nil
        clearAllTextField()
    }
}

// MARK: - Keyboard control
extension TranslationViewController: UITextFieldDelegate {
    ///Translate when a letter is typed
    func textFieldDidChangeSelection(_ textField: UITextField) {
        translate()
    }

    ///Translate
    private func translate() {
        guard let languageForTraduct = languageToTranslateTextField.text else {  return }

        language.translate(source: source, target: target, text: languageForTraduct)

        ApiService.shared.getApiResponse(apiUrl: .translateUrl) { (success, translate) in
            if success, let translate = translate as? Translate {
                self.languageTraductedTextView.text = translate.data.translations[0].translatedText
            }
        }
    }

    ///Remove the keyboard
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }

    ///Remove the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()

        return true
    }

    ///Remove the keyboard
    private func hideKeyboard() {
        languageToTranslateTextField.resignFirstResponder()
    }
}

// MARK: - Adaptive view depending on the keyboard
extension TranslationViewController {
    ///Adjust the elements according to the presence of the keyboard
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
    /// Swapping languages
    @IBAction func swap(_ sender: UIButton) {
        sender.animated()

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

        languageToTranslateTextField.text = translatedtextStorage

        translate()
    }

    ///Clear the textfields
    @IBAction func clear(_ sender: UIButton) {
        sender.animated()

        clearAllTextField()
    }

    ///Clear the textfields
    private func clearAllTextField() {
        languageToTranslateTextField.text = nil
        languageTraductedTextView.text = nil
    }
}

// MARK: - Segue to TableViewController
extension TranslationViewController {
    /// Action segue to list
    @IBAction func toList(_ sender: UIButton) {
        languageList(sender: sender)

        performSegue(withIdentifier: SegueIdentifier.translationToList.rawValue, sender: self)
    }

    /// Identify which language is the source of the action
    private func languageList(sender: UIButton) {
        if sender.tag == 0 || sender.tag == 1 {
            identifier = .languageOne
        } else if sender.tag == 2 || sender.tag == 3 {
            identifier = .languageTwo
        }
    }

    /// Pass identifier to the next controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.translationToList.rawValue {
            let tableViewController = segue.destination as! TableViewController
            tableViewController.identifier = identifier
            tableViewController.segueOrigin = segueOrigin
        } else {
            Notification.alertPost(alert: .errorData)
        }
    }
}
