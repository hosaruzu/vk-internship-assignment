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

    // MARK: - Subviews

    private let collectionView = SliderCollectionView(withPaging: true)

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionViewDelegatesAndRegistrations()
        setupSubviews()
        setupLayout()

        collectionView.backgroundColor = .systemBlue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func scrollToItem(at row: Int) {
        collectionView.selectItem(at: [0, row], animated: true, scrollPosition: .centeredHorizontally)
    }
}

// MARK: - Initialize collection view

private extension WeatherSliderView {

    func makeFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }

    func initializeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeFlowLayout())
        return collectionView
    }

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
        WeatherType.allCases.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeue(WeatherSliderCell.self, for: indexPath)
        cell.setupWith(WeatherType.allCases[indexPath.row].rawValue)
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
        onEndDragging?(offset.item)
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
