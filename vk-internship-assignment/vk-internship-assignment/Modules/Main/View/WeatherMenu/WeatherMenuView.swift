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

    // MARK: - Data source

    private var weather: [WeatherKind] = []
    private var weatherType: Weather = .clear

    // MARK: - Subviews

    private let collectionView = SliderCollectionView(withPaging: false)

    private let highlightView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.layer.cornerRadius = UIConstants.HighlightView.cornerRadius
        view.alpha = UIConstants.HighlightView.alpha
        view.clipsToBounds = true
        view.layer.cornerCurve = .continuous
        return view
    }()

    // MARK: - Dynamic constraints

    private var widthConstraint = NSLayoutConstraint()
    private var leadingConstraint = NSLayoutConstraint()
    private var selectedIndexPath: IndexPath?

    // MARK: - Flags

    /// Prevents animations on first appearance
    private var isFirstAppearance = false

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionViewDelegatesAndRegistrations()
        addSubviews()
        setupLayout()
        initDynamicConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func display(models: [WeatherKind]) {
        weather = models
    }

    func selectItem(at row: Int) {
        weatherType = Weather.allCases[row]
        collectionView(collectionView, didSelectItemAt: [0, row])
    }
}

// MARK: - Setup collection view

private extension WeatherMenuView {
    func setupCollectionViewDelegatesAndRegistrations() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherMenuCell.self)
    }
}

// MARK: - Setup subviews

private extension WeatherMenuView {
    func addSubviews() {
        addSubviews([
            highlightView,
            collectionView
        ])
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            highlightView.topAnchor.constraint(equalTo: topAnchor),
            highlightView.bottomAnchor.constraint(equalTo: bottomAnchor),

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
        weather.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeue(WeatherMenuCell.self, for: indexPath)
        let weather = weather[indexPath.item]
        cell.setCellCategory(weather)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension WeatherMenuView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        animateCollectionView(indexPath)
        moveHighlightView(indexPath)
        onSectionChange?(indexPath.item)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let selectedIndexPath else { return }
        moveHighlightView(selectedIndexPath, animate: false)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WeatherMenuView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = weather[indexPath.item].type.name.localized().defineWidth()
        return CGSize(width: width + UIConstants.Cell.horizontalPadding, height: collectionView.frame.height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIConstants.CollectionView.insets
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

// MARK: - Animation helpers

private extension WeatherMenuView {
    func move(originX: CGFloat, width: CGFloat, animation: Bool = true) {
        self.widthConstraint.constant = width
        self.leadingConstraint.constant = originX
        changeLayoutWithAnimation(animation)
    }

    func changeLayoutWithAnimation(_ animation: Bool) {
        if isFirstAppearance && animation {
            UIView.animate(withDuration: UIConstants.Animation.duration) {
                self.layoutIfNeeded()
            }
        } else {
            self.layoutIfNeeded()
        }
        isFirstAppearance = true
    }

    func initDynamicConstraints() {
        let initialWidth = weatherType.name.localized().defineWidth()
        widthConstraint = highlightView.widthAnchor.constraint(equalToConstant: initialWidth)
        leadingConstraint = highlightView.leadingAnchor.constraint(equalTo: leadingAnchor)
        widthConstraint.isActive = true
        leadingConstraint.isActive = true
    }

    func animateCollectionView(_ indexPath: IndexPath) {
        if isFirstAppearance {
            UIView.animate(withDuration: UIConstants.Animation.duration) {
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }
        } else {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }

    func moveHighlightView(_ indexPath: IndexPath, animate: Bool = true) {
        guard let attributes = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        let cellRect = attributes.frame
        let cellFrameInSuperView = collectionView.convert(cellRect, to: collectionView.superview)
        move(originX: cellFrameInSuperView.origin.x, width: cellFrameInSuperView.width, animation: animate)
    }
}

// MARK: - UI constants

private enum UIConstants {
    enum CollectionView {
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    enum HighlightView {
        static let cornerRadius: CGFloat = 16
        static let alpha: CGFloat = 0.9
    }

    enum Cell {
        static let horizontalPadding: CGFloat = 50
    }

    enum Animation {
        static let duration: TimeInterval = 0.4
    }
}
