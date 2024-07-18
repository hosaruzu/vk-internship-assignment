//
//  WeatherSliderView.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 17.07.2024.
//

import UIKit

final class WeatherSliderView: UIView {

    // MARK: - Callbacks

    var onEndDragging: ((Int) -> Void)?

    // MARK: - Data source

    private var weather: [WeatherKind] = []
    private var initialItem = 0 {
        didSet {
            setupGradient()
            animateGradient()
        }
    }

    // MARK: - Subviews

    private let collectionView = SliderCollectionView(withPaging: true)

    // MARK: - Layers

    private let gradientLayer = CAGradientLayer()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionViewDelegatesAndRegistrations()
        setupSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    // MARK: - Public

    func display(models: [WeatherKind], initialItem: Int) {
        self.weather = models
        self.initialItem = initialItem
    }

    func scrollToItem(at row: Int) {
        initialItem = row
        collectionView.selectItem(at: [0, row], animated: true, scrollPosition: .centeredHorizontally)
    }
}

// MARK: - Initialize collection view

private extension WeatherSliderView {
    func setupCollectionViewDelegatesAndRegistrations() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherSliderCell.self)
    }
}

// MARK: - Setup subviews

private extension WeatherSliderView {
    func setupSubviews() {
        addSubviews([collectionView])
        layer.addSublayer(gradientLayer)
        layer.addSublayer(collectionView.layer)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension WeatherSliderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weather.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeue(WeatherSliderCell.self, for: indexPath)
        let weatherItem = weather[indexPath.item]
        cell.setupWith(weatherItem)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let cell = cell as? WeatherSliderCell else { return }
        cell.showWithAnimation()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let cell = cell as? WeatherSliderCell else { return }
        cell.hide()
    }
}

// MARK: - UICollectionViewDelegate

extension WeatherSliderView: UICollectionViewDelegate {

    /// trigger changing offset only when item is changed
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let offset = IndexPath(item: Int(targetContentOffset.pointee.x / frame.width), section: 0)
        performSlidingWith(offset)
    }

    /// prevent performing dragging and animations on first item to left and last item to right
    func performSlidingWith(_ offset: IndexPath) {
        if initialItem > offset.item || initialItem < offset.item {
            initialItem = offset.item
            onEndDragging?(offset.item)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WeatherSliderView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        .init(width: bounds.width, height: frame.height)
    }
}

// MARK: - Setup gradients

private extension WeatherSliderView {
    func setupGradient() {
        gradientLayer.colors = [
            UIColor(hexString: weather[initialItem].gradient.end).cgColor,
            UIColor(hexString: weather[initialItem].gradient.start).cgColor
        ]
        gradientLayer.startPoint = UIConstants.Gradient.startPoint
        gradientLayer.endPoint = UIConstants.Gradient.endPoint
        gradientLayer.locations = UIConstants.Gradient.locations
    }

    func animateGradient() {
        let colorAnimation = CABasicAnimation(keyPath: UIConstants.Animation.name)
        colorAnimation.fromValue = UIConstants.Animation.fromValue
        colorAnimation.toValue = UIConstants.Animation.toValue
        colorAnimation.duration = UIConstants.Animation.duration
        gradientLayer.add(colorAnimation, forKey: nil)
    }
}

// MARK: - UI constants

private enum UIConstants {
    enum Gradient {
        static let startPoint: CGPoint = .init(x: 0.0, y: 1)
        static let endPoint: CGPoint = .init(x: 0.0, y: 0.5)
        static let locations: [NSNumber] = [0, 1]
    }

    enum Animation {
        static let name = "locations"
        static let fromValue: [Double] = [0, 0.2]
        static let toValue: [Double] = [0, 1]
        static let duration: CFTimeInterval = 2
    }
}
