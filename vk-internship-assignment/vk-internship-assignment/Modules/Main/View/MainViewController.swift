//
//  MainViewController.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

final class MainViewController: BaseViewController {

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

            weatherCategoriesView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: UIConstant.Common.verticalOffset),
            weatherCategoriesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherCategoriesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherCategoriesView.heightAnchor.constraint(equalToConstant: UIConstant.Categories.height),

            localeButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: UIConstant.Button.leadingOffset),
            localeButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -UIConstant.Common.verticalOffset),
            localeButton.heightAnchor.constraint(equalToConstant: UIConstant.Button.height),
            localeButton.widthAnchor.constraint(equalToConstant: UIConstant.Button.width)
        ])
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {
    var onLocaleButtonTap: (() -> Void)? {
        get {
            localeButton.onMenuAction
        }
        set {
            localeButton.onMenuAction = newValue
        }
    }

    func display(models: [WeatherKind], initialItem: Int, locale: String) {
        weatherSliderView.display(models: models, initialItem: initialItem)
        weatherCategoriesView.display(models: models)
        Task {
            weatherCategoriesView.selectItem(at: initialItem)
        }
        localeButton.setTitle(locale)
    }
}

// MARK: - UI constants

private enum UIConstant {
    enum Categories {
        static let height: CGFloat = 60
    }

    enum Button {
        static let width: CGFloat = 40
        static let height: CGFloat = 50
        static let leadingOffset: CGFloat = 16
    }

    enum Common {
        static let verticalOffset: CGFloat = 12
    }
}
