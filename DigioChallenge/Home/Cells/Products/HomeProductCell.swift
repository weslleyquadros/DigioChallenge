//
//  HomeProductCell.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

class HomeProductCell: UICollectionViewCell, CodeView {
    
    static let reuseIdentifier = "HomeProductCell"

    private let horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    var viewModel: [Product]? {
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
    
    func configure(with model: [Product]) {
        viewModel = model
    }

}

//MARK: - CodeView

extension HomeProductCell {
    func buildViewHierarchy() {
        contentView.addSubview(horizontalCollectionView)
    }
    
    func setupConstraints() {
        horizontalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            horizontalCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        horizontalCollectionView.register(HomeProductItemCell.self, forCellWithReuseIdentifier: HomeProductItemCell.reuseIdentifier)
    }
}

extension HomeProductCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductItemCell.reuseIdentifier, for: indexPath) as! HomeProductItemCell
        cell.configure(with: viewModel![indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
