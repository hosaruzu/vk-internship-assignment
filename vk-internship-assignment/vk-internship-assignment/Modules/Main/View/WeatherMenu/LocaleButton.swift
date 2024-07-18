//
//  LocaleButton.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 18.07.2024.
//

import UIKit

final class LocaleButton: UIButton {

    // MARK: - Callbacks
    var onMenuAction: ((LocaleType) -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupDropdown()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup appearance

private extension LocaleButton {
    func setupAppearance() {
        setTitleColor(.white, for: .normal)
        backgroundColor = UIConstants.backgroundColor
        layer.cornerRadius = UIConstants.cornerRadius
        layer.cornerCurve = .continuous
        clipsToBounds = true
    }
}

// MARK: - Setup dropdown

private extension LocaleButton {
    func setupDropdown() {
        menu = makeDropdown()
        showsMenuAsPrimaryAction = true
    }

    func makeDropdown() -> UIMenu {
        let english = UIAction(title: LocaleType.eng.name) { _ in
            self.onMenuAction?(.eng)
            self.setTitle(LocaleType.eng.name, for: .normal)
        }
        let russian = UIAction(title: LocaleType.rus.name) { _ in
            self.onMenuAction?(.rus)
            self.setTitle(LocaleType.rus.name, for: .normal)
        }
        return UIMenu(title: "", children: [english, russian])
    }
}

// MARK: - UI constants

private enum UIConstants {
    static let cornerRadius: CGFloat = 14
    static let backgroundColor: UIColor = .black.withAlphaComponent(0.6)
}
