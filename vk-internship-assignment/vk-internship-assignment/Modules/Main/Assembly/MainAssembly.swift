//
//  MainAssembly.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

final class MainAssembly {
   @MainActor func build() -> UIViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter()
        viewController.addPresenterRef(presenter)
        presenter.view = viewController
        return viewController
    }
}
