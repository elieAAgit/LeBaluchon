//
//  UserPreferences.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 15/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

class UserPreferences {
    /// Storage preferences titles sections
    static let sections = ["Langues", "Devises", "Villes"]

    /// Keys for use Userdefaults methods
    private struct Keys {
        static let languageOne = "languageOne"
        static let languageTwo = "languageTwo"
        static let currencyOne = "currencyOne"
        static let currencyTwo = "currencyTwo"
        static let cityOne = "cityOne"
        static let cityTwo = "cityTwo"
    }

    /// To save the user's preferred language one
    static var languageOne: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.languageOne) ?? "Français"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.languageOne)
        }
    }

    /// To save the user's preferred language two
    static var languageTwo: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.languageTwo) ?? "Anglais"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.languageTwo)
        }
    }

    /// To save the user's preferred currency one
    static var currencyOne: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.currencyOne) ?? "Euro"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.currencyOne)
        }
    }

    /// To save the user's preferred currency two
    static var currencyTwo: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.currencyTwo) ?? "United States Dollar"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.currencyTwo)
        }
    }

    /// To save the user's preferred city one
    static var cityOne: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.currencyTwo) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.currencyTwo)
        }
    }

    /// To save the user's preferred city two
    static var cityTwo: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.currencyTwo) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.currencyTwo)
        }
    }
}
