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
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setCellCategory(_ name: String) {
        weatherTypeNameLabel.text = name
    }
}

// MARK: - Setup subviews

private extension WeatherMenuCell {
    func setupSubviews() {
        contentView.addSubviews([weatherTypeNameLabel])
        NSLayoutConstraint.activate([
            weatherTypeNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            weatherTypeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherTypeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weatherTypeNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
}
