//
//  WeatherService.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 18.07.2024.
//

import Foundation

protocol WeatherService {
    func obtainInitialWeatherItem() -> Int
    func obtainWeather() -> [WeatherKind]
}

final class WeatherServiceImp: WeatherService {

    func obtainWeather() -> [WeatherKind] {
        return WeatherKind.mock
    }

    func obtainInitialWeatherItem() -> Int {
        return Int.random(in: 0..<WeatherKind.mock.count)
    }
}
