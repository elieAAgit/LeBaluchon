//
//  LanguageService.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 06/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

class LanguageService {
    func translate(source: String, target: String, text: String) {
        ApiKeys.parameters = "&source=\(source)&target=\(target)&q=\(text)"
    }
}
