//
//  MainPresenter.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import Foundation

@MainActor
final class MainPresenter {

    let randomNumber = Int.random(in: 0..<WeatherKind.mock.count)

    // MARK: - View reference

    weak var view: MainViewInput? {
        didSet {
            setupInitialWeather()
        }
    }

    func setupInitialWeather() {
        view?.onViewDidLoad = { [weak self] in
            guard let randomNumber = self?.randomNumber else { return }
            self?.view?.setInitialWeather(randomNumber)
            self?.handleDisplaying()
        }
    }

    func handleDisplaying() {
        let weather = WeatherKind.mock
        view?.display(models: weather, initialItem: self.randomNumber)
    }
}
