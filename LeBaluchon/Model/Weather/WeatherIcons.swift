//
//  WeatherIcons.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 11/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

class WeatherIcons {
    let icons = ["01d", "01n", "02d", "02n", "03d", "03n", "04d", "04n", "09d", "09n", "10d", "10n", "11d", "11n", "13d", "13n", "50d", "50n"]

    /// Using only to prevent icon missing to replace by default icon
    func weatherIcons(icon: String) -> String {
        var assign: String

        if icons.contains(icon) {
            assign = icon
        } else {
            assign = "default"
        }

        return assign
    }
}
