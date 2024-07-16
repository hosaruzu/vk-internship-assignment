//
//  MainViewInput.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import Foundation

@MainActor
protocol MainViewInput: AnyObject {
    var onViewDidLoad: (() -> Void)? { get set }
    func setInitialWeather(_ row: Int)
}
