//
//  MenuCollectionViewCell.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

final class WeatherMenuCell: UICollectionViewCell {

    // MARK: - Subviews

    private let weatherTypeNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIConstants.Label.color
        label.font = UIConstants.Label.font
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setCellCategory(_ name: String) {
        weatherTypeNameLabel.text = name
    }
}

private extension WeatherMenuCell {
    func setupAppearance() {
        layer.cornerRadius = UIConstants.Cell.cornerRadius
        backgroundColor = UIConstants.Cell.backgroundColor
    }
}

// MARK: - Setup subviews

private extension WeatherMenuCell {
    func setupSubviews() {
        contentView.addSubviews([weatherTypeNameLabel])
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            weatherTypeNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            weatherTypeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherTypeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weatherTypeNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
}

// MARK: - UI constans

private enum UIConstants {
    enum Label {
        static let font: UIFont = .systemFont(ofSize: 16, weight: .medium)
        static let color: UIColor = .label
    }

    enum Cell {
        static let cornerRadius: CGFloat = 16
        static let backgroundColor: UIColor = .systemBackground.withAlphaComponent(0.1)
    }
}
