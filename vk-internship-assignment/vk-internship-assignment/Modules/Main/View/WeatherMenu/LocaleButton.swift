//
//  LocaleButton.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 18.07.2024.
//

import UIKit

final class LocaleButton: UIButton {

    // MARK: - Callbacks
    var onMenuAction: (() -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupDropdown()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setTitle(_ string: String) {
        if string == "en" {
            setTitle("🇺🇸", for: .normal)
        } else if string == "ru" {
            setTitle("🇷🇺", for: .normal)
        }
    }
}

// MARK: - Setup appearance

private extension LocaleButton {
    func setupAppearance() {
        backgroundColor = UIConstants.backgroundColor
        layer.cornerRadius = UIConstants.cornerRadius
        layer.cornerCurve = .continuous
        clipsToBounds = true
    }
}

// MARK: - Setup dropdown

private extension LocaleButton {
    func setupDropdown() {
        addAction(makeAction(), for: .touchUpInside)
    }

    func makeAction() -> UIAction {
        let action = UIAction { [weak self] _ in
            self?.onMenuAction?()
        }
        return action
    }
}

// MARK: - UI constants

private enum UIConstants {
    static let cornerRadius: CGFloat = 14
    static let backgroundColor: UIColor = .black.withAlphaComponent(0.6)
}
