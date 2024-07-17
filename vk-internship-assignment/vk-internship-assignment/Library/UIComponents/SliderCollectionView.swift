//
//  WeatherSliderCollectionView.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 17.07.2024.
//

import UIKit

final class SliderCollectionView: UICollectionView {

    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }()

    // MARK: - Init

    init(withPaging: Bool) {
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        isPagingEnabled = withPaging
        setupAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup appearance

private extension SliderCollectionView {
    func setupAppearance() {
        bounces = false
        showsHorizontalScrollIndicator = false
    }
}
