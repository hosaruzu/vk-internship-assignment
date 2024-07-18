//
//  MainViewController.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

final class MainViewController: BaseViewController {

    let defaults = UserDefaults.standard

    // MARK: - Subviews

    private let weatherCategoriesView = WeatherMenuView()
    private let weatherSliderView = WeatherSliderView()
    private let localeButton = LocaleButton()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupSubviews()
        setupConstraints()
        setupBindings()
    }
}

// MARK: - Setup appearance

private extension MainViewController {
    func setupAppearance() {
        view.backgroundColor = .systemBackground
    }
}

// MARK: - Setup bindings

private extension MainViewController {

    func setupBindings() {
        weatherCategoriesView.onSectionChange = { [weak self] row in
            self?.weatherSliderView.scrollToItem(at: row)
        }

        weatherSliderView.onEndDragging = { [weak self] item in
            self?.weatherCategoriesView.selectItem(at: item)
        }

        localeButton.onMenuAction = { [weak self] locale in
            let string = locale.rawValue
            self?.defaults.set(string, forKey: "locale")
        }
    }
}

// MARK: - Setup layout

private extension MainViewController {
    func setupSubviews() {
        view.addSubviews([
            weatherSliderView,
            weatherCategoriesView,
            localeButton
        ])
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherSliderView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherSliderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherSliderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherSliderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            weatherCategoriesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherCategoriesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherCategoriesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherCategoriesView.heightAnchor.constraint(equalToConstant: UIConstant.Categories.height),

            localeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            localeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            localeButton.heightAnchor.constraint(equalToConstant: 40),
            localeButton.widthAnchor.constraint(equalToConstant: 54)
        ])
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {
    func setInitialWeather(_ row: Int) {
        Task {
            weatherCategoriesView.selectItem(at: row)
            weatherSliderView.scrollToItem(at: row)
        }
    }

    func display(models: [WeatherKind], initialItem: Int) {
        weatherSliderView.display(models: models, initialItem: initialItem)
        weatherCategoriesView.display(models: models)
        let title = defaults.object(forKey: "locale") as? String
        localeButton.setTitle(title, for: .normal)
    }
}

// MARK: - UI constants

private enum UIConstant {
    enum Categories {
        static let height: CGFloat = 60
    }
}
