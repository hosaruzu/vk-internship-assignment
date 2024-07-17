//
//  MainViewController.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

final class MainViewController: BaseViewController {

    // MARK: - Subviews

    private var weatherCategoriesView = WeatherMenuView()
    private let weatherSliderView = WeatherSliderView()

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
    }
}

// MARK: - Setup layout

private extension MainViewController {
    func setupSubviews() {
        view.addSubviews([
            weatherSliderView,
            weatherCategoriesView
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
            weatherCategoriesView.heightAnchor.constraint(equalToConstant: UIConstant.Categories.height)
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
    }
}

// MARK: - UI constants

private enum UIConstant {
    enum Categories {
        static let height: CGFloat = 60
    }
}
