//
//  MenuView.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 04.05.2024.
//

import UIKit

final class WeatherSelectorView: UIView {

    // MARK: - Callbacks

    var onSectionChange: ((Int) -> Void)?

    // MARK: - Subviews

    private var collectionView: UICollectionView?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView = initializeCollectionView()
        setupCollectionViewDelegatesAndRegistrations()
        setupCollectionViewAppearance()
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func selectItem(at row: Int, animated: Bool = true) {
        collectionView?.selectItem(at: [0, row], animated: animated, scrollPosition: .centeredHorizontally)
    }
}

// MARK: - Setup collection view

private extension WeatherSelectorView {
    func makeFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }

    func initializeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeFlowLayout())
        return collectionView
    }

    func setupCollectionViewAppearance() {
        guard let collectionView else { return }
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.selectItem(at: [0, 0], animated: false, scrollPosition: [])
    }

    func setupCollectionViewDelegatesAndRegistrations() {
        guard let collectionView else { return }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherSelectorCell.self)
    }
}

// MARK: - Setup subviews

private extension WeatherSelectorView {
    func addSubviews() {
        guard let collectionView else { return }
        addSubviews([
            collectionView
        ])
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

extension WeatherSelectorView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        WeatherType.allCases.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeue(WeatherSelectorCell.self, for: indexPath)
        cell.setCellCategory(WeatherType.allCases[indexPath.item].rawValue)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension WeatherSelectorView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        onSectionChange?(indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WeatherSelectorView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = WeatherType.allCases[indexPath.item].rawValue.defineWidth()
        return CGSize(width: width + Spec.Cell.padding, height: collectionView.frame.height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        Spec.CollectionView.insets
    }

    /// For prevent menu cell sliding from bottom on displaying
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        WeatherSelectorCell.performWithoutAnimation {
            cell.layoutIfNeeded()
        }
    }
}

// MARK: - UI constants

private enum Spec {
    enum CollectionView {
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }

    enum Cell {
        static let padding: CGFloat = 24
    }
}
