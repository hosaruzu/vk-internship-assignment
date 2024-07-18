//
//  MainViewInput.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import Foundation

protocol MainViewInput: AnyObject {
    var onViewDidLoad: (() -> Void)? { get set }
    var onLocaleButtonTap: (() -> Void)? { get set }
    func display(models: [WeatherKind], initialItem: Int, locale: String)
}
