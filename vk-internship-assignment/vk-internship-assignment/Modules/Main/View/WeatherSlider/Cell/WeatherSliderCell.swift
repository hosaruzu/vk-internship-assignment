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
        view.layer.cornerCurve = .continuous
        return view
    }()

    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()

    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.textColor = .white
        return label
    }()

    private let weatherImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayout()
        addBackgroundViewTapGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setupWith(_ model: WeatherKind) {
        weatherLabel.text = model.type.name
        weatherImageView.image = UIImage(systemName: model.imageName)
    }

    func showWithAnimation() {
        UIView.animate(
            withDuration: UIConstants.Animation.duration,
            delay: UIConstants.Animation.delay
        ) {
            self.blurBackgroundView.alpha = UIConstants.BackgroundView.alpha
            self.blurBackgroundView.transform = .identity
        }
    }

    func hide() {
        UIView.animate(withDuration: UIConstants.Animation.duration) {
                self.blurBackgroundView.alpha = 0
                self.blurBackgroundView.transform = UIConstants.BackgroundView.initialTransform
            }
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

            weatherImageView.centerYAnchor.constraint(
                equalTo: blurBackgroundView.centerYAnchor,
                constant: -UIConstants.Common.centerOffset),
            weatherImageView.centerXAnchor.constraint(equalTo: blurBackgroundView.centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: UIConstants.Image.width),
            weatherImageView.heightAnchor.constraint(equalToConstant: UIConstants.Image.width),

            weatherLabel.centerXAnchor.constraint(equalTo: blurBackgroundView.centerXAnchor),
            weatherLabel.centerYAnchor.constraint(
                equalTo: blurBackgroundView.centerYAnchor,
                constant: UIConstants.Common.centerOffset)
        ])
    }

    func addBackgroundViewTapGesture() {
        blurBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
    }

    @objc
    func onTap() {
        UIView.animate(withDuration: UIConstants.Tap.durationIn) {
            self.blurBackgroundView.transform = UIConstants.BackgroundView.initialTransform
        } completion: { _ in
            UIView.animate(withDuration: UIConstants.Tap.durationOut) {
                self.blurBackgroundView.transform = .identity
            }
        }
    }
}

// MARK: - UI constants

private enum UIConstants {
    enum Animation {
        static let duration: TimeInterval = 0.2
        static let delay: TimeInterval = 0.3
    }

    enum BackgroundView {
        static let initialTransform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        static let cornerRadius: CGFloat = 26
        static let widthMultipier: CGFloat = 0.6
        static let heightMultipier: CGFloat = 0.7
        static let alpha: CGFloat = 0.9
    }

    enum Image {
        static let width: CGFloat = 100
        static let height: CGFloat = 100
    }

    enum Common {
        static let centerOffset: CGFloat = 40
    }

    enum Tap {
        static let durationIn: TimeInterval = 0.1
        static let durationOut: TimeInterval = 0.2
    }
}
