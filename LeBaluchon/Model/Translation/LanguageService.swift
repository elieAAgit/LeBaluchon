//
//  LanguageService.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 06/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

class LanguageService {
    /// Add parameters to Google translate Api: language source, language tarfet and text to translate
    func translate(source: String, target: String, text: String) {
        guard let source = LanguageStorage.languageValue[source] else {
            return Notification.alertPost(alert: .languageUnknown)
        }

        guard let target = LanguageStorage.languageValue[target] else {
            return Notification.alertPost(alert: .languageUnknown)
        }

        ApiKeys.parameters = "&source=\(source)&target=\(target)&q=\(text)"
    }
}
