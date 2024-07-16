//
//  WeatherMenuView.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

final class WeatherMenuView: UIView {

    // MARK: - Callbacks

    var onSectionChange: ((Int) -> Void)?
    var withAnimation = false

    // MARK: - Subviews

    private var collectionView: UICollectionView?
    private var initialWeatherType: WeatherType = .clear

    private let lineView = UIView()
    private var widthConstraint = NSLayoutConstraint()
    private var leadingConstraint = NSLayoutConstraint()

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
        initialWeatherType = WeatherType.allCases[row]
        collectionView(collectionView ?? UICollectionView(), didSelectItemAt: [0, row])
    }
}

// MARK: - Setup collection view

private extension WeatherMenuView {
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
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.selectItem(at: [0, 0], animated: false, scrollPosition: [])
    }

    func setupCollectionViewDelegatesAndRegistrations() {
        guard let collectionView else { return }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherMenuCell.self)
    }

    func move(originX: CGFloat, width: CGFloat) {
        self.widthConstraint.constant = width
        self.leadingConstraint.constant = originX
        if withAnimation {
            UIView.animate(withDuration: 0.4) {
                self.layoutIfNeeded()
            }
        } else {
            self.layoutIfNeeded()
        }
        withAnimation = true
    }
}

// MARK: - Setup subviews

private extension WeatherMenuView {
    func addSubviews() {
        guard let collectionView else { return }
        addSubviews([
            lineView,
            collectionView
        ])
    }

    func setupLayout() {
        guard let collectionView else { return }
        lineView.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.4)
        lineView.layer.cornerRadius = 16

        let initialWidth = initialWeatherType.rawValue.defineWidth()
        widthConstraint = lineView.widthAnchor.constraint(equalToConstant: initialWidth + 20)
        widthConstraint.isActive = true
        leadingConstraint = lineView.leadingAnchor.constraint(equalTo: leadingAnchor)
        leadingConstraint.isActive = true

        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),

            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension WeatherMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        WeatherType.allCases.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeue(WeatherMenuCell.self, for: indexPath)
        cell.setCellCategory(WeatherType.allCases[indexPath.item].rawValue)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension WeatherMenuView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if withAnimation {
            UIView.animate(withDuration: 0.5) {
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }
        } else {
            self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
        guard let attributes = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        let cellRect = attributes.frame
        let cellFrameInSuperView = collectionView.convert(cellRect, to: collectionView.superview)
        move(originX: cellFrameInSuperView.origin.x, width: cellFrameInSuperView.width)
        onSectionChange?(indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WeatherMenuView: UICollectionViewDelegateFlowLayout {
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
        WeatherMenuCell.performWithoutAnimation {
            cell.layoutIfNeeded()
        }
    }
}

// MARK: - UI constants

private enum Spec {
    enum CollectionView {
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    enum Cell {
        static let padding: CGFloat = 24
    }
}
