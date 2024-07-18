//
//  LocaleType.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 18.07.2024.
//

import Foundation

enum LocaleType: String {
    case rus
    case eng

    var name: String {
        rawValue.uppercased()
    }
}
