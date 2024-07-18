//
//  MainPresenter.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import Foundation

final class MainPresenter {

    // MARK: - Dependencies

    private let weatherService: WeatherService
    private let router: Router

    // MARK: - Init

    init(
        weatherService: some WeatherService,
        router: some Router
    ) {
        self.weatherService = weatherService
        self.router = router

    }

    // MARK: - View reference

    weak var view: MainViewInput? {
        didSet {
            onLoad()
        }
    }

    // MARK: - Display on load

    private func onLoad() {
        view?.onViewDidLoad = { [weak self] in
            self?.handleDisplaying()
        }

        view?.onLocaleButtonTap = { [weak self] in
            self?.openLanguagePreferences()
        }
    }

    private func handleDisplaying() {
        let currentLang = getCurrentLanguage()
        let item = weatherService.obtainInitialWeatherItem()
        let weatherModels = weatherService.obtainWeather()
        view?.display(models: weatherModels, initialItem: item, locale: currentLang)
    }

    // MARK: - Get current app locale

    private func getCurrentLanguage() -> String {
        guard let languageCode = NSLocale.current.languageCode else { return "en" }
        return languageCode
    }

    // MARK: - Router

    private func openLanguagePreferences() {
        router.presentLanguagePreferences()
    }
}
