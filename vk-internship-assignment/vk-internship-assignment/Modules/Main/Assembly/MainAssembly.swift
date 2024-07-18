//
//  MainAssembly.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

final class MainAssembly {
    func build() -> UIViewController {
        let viewController = MainViewController()
        let router = RouterImpl()
        let weatherService = WeatherServiceImp()
        let presenter = MainPresenter(weatherService: weatherService, router: router)
        viewController.addPresenterRef(presenter)
        presenter.view = viewController
        return viewController
    }
}
