//
//  SegueIdentifier.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 12/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

/// Names of the different segue used
enum SegueIdentifier: String {
    case translationToList = "translationList"
    case changeToList = "changeList"
    case weatherToList = "weatherList"
    case weatherToDetail = "weatherDetail"
    case weatherToSearch = "searchCity"
    case preferencesToList = "preferencesList"
    case preferencesToSearch = "preferencesCity"
    case toTranslation = "translationSegue"
    case toChange = "changeSegue"
    case toWeather = "weatherSegue"
    case toPreferences = "preferencesSegue"
    case searchToPreferences = "searchToPreferences"
}

/// List of different useful identifiers for displaying the correct list and retrieve the data
enum Identifier {
    case languageOne, languageTwo, currencyOne, currencyTwo, cityOne, cityTwo
}
