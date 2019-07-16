//
//  ApiKeys.swift
//  Twittermenti
//
//  Created by serena on 7/16/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

func valueForAPIKey(named keyname:String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}
