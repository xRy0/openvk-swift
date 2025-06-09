//
//  UserDefaults.swift
//  ovk
//
//  Created by Isami Riša on 25.10.2023.
//

import Foundation

func getValueFromUserDefaults(forKey key: String) -> String? {
    return UserDefaults.standard.string(forKey: key)
}

func getArrayFromUserDefaults(forKey key: String) -> Array<String>? {
    return UserDefaults.standard.stringArray(forKey: key)
}

func saveValueToUserDefaults(forKey key: String, value: String) {
    UserDefaults.standard.set(value, forKey: key)
}

func saveArrayToUserDefaults(forKey key: String, value: Array<String>) {
    UserDefaults.standard.set(value, forKey: key)
}

func deleteValueFromUserDefaults(forKey key: String) {
    UserDefaults.standard.removeObject(forKey: key)
}
