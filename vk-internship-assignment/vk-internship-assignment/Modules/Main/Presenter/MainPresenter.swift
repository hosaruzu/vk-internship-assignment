//
//  MainPresenter.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import Foundation

final class MainPresenter {

    // MARK: - View reference

    @MainActor
    weak var view: MainViewInput? {
        didSet {
            setupInitialWeather()
        }
    }

    @MainActor
    func setupInitialWeather() {
        let randomNumber = Int.random(in: 0..<WeatherType.allCases.count)
        view?.onViewDidLoad = { [weak self] in
            self?.view?.setInitialWeather(randomNumber)
        }
    }
}
