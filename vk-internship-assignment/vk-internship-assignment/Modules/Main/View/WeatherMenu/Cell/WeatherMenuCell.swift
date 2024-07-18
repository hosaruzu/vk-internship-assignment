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

    private let weatherImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = UIConstants.Image.tintColor
        image.contentMode = .scaleAspectFit
        return image
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

    func setCellCategory(_ weather: WeatherKind) {
        weatherTypeNameLabel.text = weather.type.name
        weatherImageView.image = UIImage(systemName: weather.imageName)
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
        contentView.addSubviews([weatherImageView, weatherTypeNameLabel])
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            weatherImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: UIConstants.Image.leadingOffset),
            weatherImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: UIConstants.Image.width),
            weatherImageView.heightAnchor.constraint(equalToConstant: UIConstants.Image.height),

            weatherTypeNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            weatherTypeNameLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor),
            weatherTypeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weatherTypeNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
}

// MARK: - UI constans

private enum UIConstants {
    enum Label {
        static let font: UIFont = .systemFont(ofSize: 16, weight: .medium)
        static let color: UIColor = .white
    }

    enum Cell {
        static let cornerRadius: CGFloat = 16
        static let backgroundColor: UIColor = .black.withAlphaComponent(0.2)
    }

    enum Image {
        static let leadingOffset: CGFloat = 8
        static let width: CGFloat = 20
        static let height: CGFloat = 20
        static let tintColor = UIConstants.Label.color.withAlphaComponent(0.5)
    }
}
