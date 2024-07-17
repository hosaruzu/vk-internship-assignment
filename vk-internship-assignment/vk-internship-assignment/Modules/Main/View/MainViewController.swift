//
//  MainViewController.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

final class MainViewController: BaseViewController {

    // MARK: - Subviews

    private var menuView = WeatherMenuView()
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
        menuView.onSectionChange = { [weak self] row in
            self?.weatherSliderView.scrollToItem(at: row)
        }

        weatherSliderView.onEndDragging = { [weak self] item in
            self?.menuView.selectItem(at: item)
        }
    }
}

// MARK: - Setup layout

private extension MainViewController {
    func setupSubviews() {
        view.addSubviews([
            weatherSliderView,
            menuView
        ])
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherSliderView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherSliderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherSliderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherSliderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {
    func setInitialWeather(_ row: Int) {
        Task {
            menuView.selectItem(at: row)
            weatherSliderView.scrollToItem(at: row)
        }
    }

    func display(models: [WeatherKind], initialItem: Int) {
        weatherSliderView.display(models: models, initialItem: initialItem)
        menuView.display(models: models)
    }
}
