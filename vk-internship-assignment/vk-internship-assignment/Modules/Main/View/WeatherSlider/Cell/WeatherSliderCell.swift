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
        view.layer.opacity = 0
        return view
    }()

    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()

    private let label: UILabel = {
        let label = UILabel()
        return label
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

    // MARK: - Public

    func setupWith(_ string: String) {
        label.text = string
    }

    func showWithAnimation() {
        UIView.animate(
            withDuration: UIConstants.Animation.duration,
            delay: UIConstants.Animation.delay
        ) {
            self.blurBackgroundView.transform = .identity
            self.blurBackgroundView.layer.opacity = 1
        }
    }

    func hide() {
        blurBackgroundView.transform = UIConstants.BackgroundView.initialTransform
        blurBackgroundView.layer.opacity = 0
    }
}

// MARK: - Setup subviews

private extension WeatherSliderCell {
    func setupSubviews() {
        contentView.addSubviews([blurBackgroundView])
        blurBackgroundView.addSubviews([blurEffectView, label])
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

            label.centerXAnchor.constraint(equalTo: blurBackgroundView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: blurBackgroundView.centerYAnchor)
        ])
    }
}

// MARK: - UI constants

private enum UIConstants {
    enum Animation {
        static let duration: TimeInterval = 0.4
        static let delay: TimeInterval = 0.35
    }

    enum BackgroundView {
        static let initialTransform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        static let cornerRadius: CGFloat = 16
        static let widthMultipier: CGFloat = 0.7
        static let heightMultipier: CGFloat = 0.5
    }
}
