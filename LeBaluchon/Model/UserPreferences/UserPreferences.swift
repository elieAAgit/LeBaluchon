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

    ///
    static var cityOneData: [String: String] = [:]
    static var cityTwoData: [String: String] = [:]

    /// Keys for use Userdefaults methods
    private struct Keys {
        static let languageOne = "languageOne"
        static let languageTwo = "languageTwo"
        static let currencyOne = "currencyOne"
        static let currencyTwo = "currencyTwo"
        static let cityOne = "cityOne"
        static let cityTwo = "cityTwo"
        static let cityOneId = "cityOneId"
        static let cityTwoId = "cityTwoId"
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
            return UserDefaults.standard.string(forKey: Keys.cityOne) ?? "Paris"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.cityOne)
        }
    }

    /// To save the user's preferred city one id. Default Paris: 2968815
    static var cityOneId: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.cityOneId) ?? "2968815"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.cityOneId)
        }
    }

    /// To save the user's preferred city two
    static var cityTwo: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.cityTwo) ?? "New-York"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.cityTwo)
        }
    }

    /// To save the user's preferred city one id. Default New-York: 5128581
    static var cityTwoId: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.cityTwoId) ?? "5128581"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.cityTwoId)
        }
    }
}
