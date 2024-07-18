//
//  Router.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 18.07.2024.
//

import UIKit

protocol Router {
    func presentLanguagePreferences()
}

final class RouterImpl: Router {
    func presentLanguagePreferences() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {return}
        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
    }
}
