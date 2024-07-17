//
//  WeatherSliderCell.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

final class WeatherSliderCell: UICollectionViewCell {

    // MARK: - Subviews

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
}

// MARK: - Setup subviews

private extension WeatherSliderCell {
    func setupSubviews() {
        contentView.addSubviews([label])
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - UI constants

private enum Spec {
    enum TableView {
        static let contentOffset: UIEdgeInsets = .init(top: 16, left: 0, bottom: 0, right: 0)
        static let tableViewCellHeight: CGFloat = 84
        static let numberOfShimmerCells: Int = 9
    }

    enum Cell {
        static let height: CGFloat = 84
        static let amount: Int = 9
    }

    enum EmptyStateView {
        static let top: CGFloat = 80
    }
}
