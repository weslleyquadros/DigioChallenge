//
//  HomeSpotlightCell.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

final class HomeSpotlightCell: UICollectionViewCell, CodeView {
    
    static let reuseIdentifier = "HomeSpotlightCell"

    private let horizontalCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CarouselFlowLayout())
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        return collectionView
    }()

    var viewModel: [Spotlight]? {
        didSet {
            horizontalCollectionView.reloadData()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: [Spotlight]) {
        viewModel = model
    }
}

//MARK: - CodeView

extension HomeSpotlightCell {
    func buildViewHierarchy() {
        contentView.addSubview(horizontalCollectionView)
    }
    
    func setupConstraints() {
        horizontalCollectionView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor
        )
    }
    
    func setupAdditionalConfiguration() {
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        horizontalCollectionView.register(HomeSpotlightItemCell.self, forCellWithReuseIdentifier: HomeSpotlightItemCell.reuseIdentifier)
    }
}

//MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension HomeSpotlightCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSpotlightItemCell.reuseIdentifier, for: indexPath) as? HomeSpotlightItemCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: model[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width - 72
        return CGSize(width: itemWidth, height: collectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
