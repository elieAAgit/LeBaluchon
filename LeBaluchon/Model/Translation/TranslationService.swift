//
//  TranslationService.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 06/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

/*
JSON structure from Google Translate

{
    "data": {
        "translations": [
        {
        "translatedText": ""
        }
        ]
    }
}
 */


/// Reflect the Google Translate JSON structure to decode Google response
struct Translate: Decodable {
    var data: Translations
}

struct Translations: Decodable {
    let translations: [TranslatedText]
}

struct TranslatedText: Decodable {
    let translatedText: String
}

/*
 JSON structure from Google Translate
 
 {
   "data": {
     "languages": [
       {
         "language": "",
         "name": ""
       }
     ]
   }
 }
 */

/// Reflect the Google list of languages JSON structure to decode Google response
struct Language: Decodable {
    var data: Languages
}

struct Languages: Decodable {
    let languages: [List]
}

struct List: Decodable {
    let language: String
    let name: String
}
