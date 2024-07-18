//
//  WeatherType.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import Foundation

enum Weather: String, CaseIterable {
    case clear
    case cloudy
    case rain
    case fog
    case thunderstorm
    case snow
}

extension Weather {
    var name: String {
        rawValue.capitalized.localized()
    }
}

struct WeatherKind {
    let type: Weather
    let imageName: String
    let isParticipating: Bool
    let gradient: (start: String, end: String)
}

extension WeatherKind {
    static let mock = [
        WeatherKind(
            type: .clear,
            imageName: "sun.max",
            isParticipating: false,
            gradient: ("6FCBFF", "DFF6FF")),
        WeatherKind(
            type: .cloudy,
            imageName: "cloud.fill",
            isParticipating: false,
            gradient: ("C5E0EF", "DFF6FF")
        ),
        WeatherKind(
            type: .rain,
            imageName: "cloud.rain.fill",
            isParticipating: true,
            gradient: ("B6C1C8", "DFF6FF")
        ),
        WeatherKind(
            type: .fog,
            imageName: "cloud.fog.fill",
            isParticipating: false,
            gradient: ("D4D4D4", "F4F4F4")
        ),
        WeatherKind(
            type: .thunderstorm,
            imageName: "cloud.bolt.fill",
            isParticipating: true,
            gradient: ("9FA1A3", "586F78")
        ),
        WeatherKind(
            type: .snow,
            imageName: "snowflake.circle.fill",
            isParticipating: true,
            gradient: ("DFF6FF", "FDFDFD")
        )
    ]

    func weatherFor(indexPath: IndexPath) -> WeatherKind {
        return WeatherKind.mock[indexPath.item]
    }
}
