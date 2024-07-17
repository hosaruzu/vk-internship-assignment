//
//  WeatherSliderCell.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

final class WeatherSliderCell: UICollectionViewCell {

    // MARK: - Subviews

    private let blurBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = UIConstants.BackgroundView.cornerRadius
        view.clipsToBounds = true
        view.transform = UIConstants.BackgroundView.initialTransform
        view.alpha = 0
        return view
    }()

    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()

    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.textColor = .secondaryLabel
        return label
    }()

    private let weatherImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .secondaryLabel
        image.contentMode = .scaleAspectFit
        return image
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupWith(_ model: WeatherKind) {
        weatherLabel.text = model.type.name
        weatherImageView.image = UIImage(systemName: model.imageName)
    }

    func showWithAnimation() {
        UIView.animate(
            withDuration: UIConstants.Animation.duration,
            delay: UIConstants.Animation.delay
        ) {
            self.blurBackgroundView.transform = .identity
            self.blurBackgroundView.alpha = UIConstants.BackgroundView.alpha
        }
    }

    func hide() {
        blurBackgroundView.transform = UIConstants.BackgroundView.initialTransform
        blurBackgroundView.alpha = 0
    }
}

// MARK: - Setup subviews

private extension WeatherSliderCell {
    func setupSubviews() {
        contentView.addSubviews([blurBackgroundView])
        blurBackgroundView.addSubviews([blurEffectView, weatherImageView, weatherLabel])
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            blurBackgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            blurBackgroundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            blurBackgroundView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: UIConstants.BackgroundView.widthMultipier),
            blurBackgroundView.heightAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: UIConstants.BackgroundView.widthMultipier),

            blurEffectView.topAnchor.constraint(equalTo: blurBackgroundView.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: blurBackgroundView.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: blurBackgroundView.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: blurBackgroundView.bottomAnchor),

            weatherImageView.centerYAnchor.constraint(equalTo: blurBackgroundView.centerYAnchor, constant: -40),
            weatherImageView.centerXAnchor.constraint(equalTo: blurBackgroundView.centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 100),
            weatherImageView.heightAnchor.constraint(equalToConstant: 100),

            weatherLabel.centerXAnchor.constraint(equalTo: blurBackgroundView.centerXAnchor),
            weatherLabel.centerYAnchor.constraint(equalTo: blurBackgroundView.centerYAnchor, constant: 40)
        ])
    }
}

// MARK: - UI constants

private enum UIConstants {
    enum Animation {
        static let duration: TimeInterval = 0.3
        static let delay: TimeInterval = 0.3
    }

    enum BackgroundView {
        static let initialTransform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        static let cornerRadius: CGFloat = 16
        static let widthMultipier: CGFloat = 0.7
        static let heightMultipier: CGFloat = 0.5
        static let alpha: CGFloat = 0.9
    }
}
