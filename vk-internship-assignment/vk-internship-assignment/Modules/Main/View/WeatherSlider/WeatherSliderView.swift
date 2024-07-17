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

    private(set) var collectionView: UICollectionView?
    private var currentRow: Int = 0

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView = initializeCollectionView()
        setupCollectionViewAppearance()
        setupCollectionViewDelegatesAndRegistrations()
        setupSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func scrollToItem(at row: Int, animate: Bool = true) {
        currentRow = row
        self.collectionView?.selectItem(at: [0, row], animated: animate, scrollPosition: .centeredHorizontally)
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

    func setupCollectionViewAppearance() {
        guard let collectionView else { return }
        collectionView.backgroundColor = .systemBlue
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
    }

    func setupCollectionViewDelegatesAndRegistrations() {
        guard let collectionView else { return }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherSliderCell.self)
    }
}

// MARK: - Setup subviews

private extension WeatherSliderView {

    func setupSubviews() {
        guard let collectionView else { return }
        addSubviews([collectionView])
    }

    func setupLayout() {
        guard let collectionView else { return }
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

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        cell.layer.opacity = 0
        UIView.animate(withDuration: 0.3, delay: 0.35) {
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            cell.layer.opacity = 1
            cell.layer.cornerRadius = 0.0
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layer.opacity = 0
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
