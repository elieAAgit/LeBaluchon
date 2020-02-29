//
//  ApiKeysAccess.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 29/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

func valueForAPIKey(named keyname: String) -> String {
    let filePath = Bundle.main.path(forResource: "APIKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}
