//
//  Localization.swift
//  ovk
//
//  Created by Isami Riša on 25.10.2023.
//

import Foundation

func getLocalizedString(key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

func getPlatform(platform_integer: Int) -> String {
        switch (platform_integer) {
        case 2:
            return "\(getLocalizedString(key: "from")) iPhone"
        case 4:
            return "\(getLocalizedString(key: "from")) Android"
        case 7:
            return ""
        default:
            return "\(getLocalizedString(key: "from")) API"
        }
    }
