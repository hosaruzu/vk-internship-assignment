//
//  MainViewController.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

final class MainViewController: BaseViewController {

    // MARK: - Subviews

    private var menuView = WeatherSelectorView()
    private let weatherView = WeatherSliderView()

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
            self?.weatherView.scrollToItem(at: row)
        }

        weatherView.onEndDragging = { [weak self] item in
            self?.menuView.selectItem(at: item)
        }
    }
}

// MARK: - Setup layout

private extension MainViewController {
    func setupSubviews() {
        view.addSubviews([
            menuView,
            weatherView
        ])
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuView.heightAnchor.constraint(equalToConstant: 60),

            weatherView.topAnchor.constraint(equalTo: menuView.bottomAnchor),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {
    func setInitialWeather(_ row: Int) {
        Task {
            menuView.selectItem(at: row, animated: false)
            weatherView.scrollToItem(at: row, animate: false)
        }
    }
}
