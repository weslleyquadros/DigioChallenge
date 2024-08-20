//
//  HomeViewController.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

protocol HomeViewControllerClickDelegate: AnyObject {
    func clickCell(name: String, description: String)
}

class HomeViewController: UIViewController {

    public var delegate: MainCoordinatorDelegate?
    private var viewModel: HomeViewModelProtocol
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    private let errorView = ErrorView()

    init(viewModel: HomeViewModelProtocol = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.fetchHomeData()
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showErrorView() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorView)

        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        errorView.setRetryAction(target: self, action: #selector(retryButtonTapped))
    }

    func removeErrorView() {
        errorView.removeFromSuperview()
    }

    @objc private func retryButtonTapped() {
        removeErrorView()
        viewModel.fetchHomeData()
    }

    private func setupBindings() {
        viewModel.onSuccess = { [weak self] in
            self?.updateUI()
        }

        viewModel.onError = { [weak self] _ in
            self?.showErrorView()
        }
    }

    private func updateUI() {
        if viewModel.homeData != nil {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.layoutIfNeeded()
                self.collectionView.visibleCells.forEach { cell in
                    cell.contentView.stopShimmering()
                }

                self.collectionView.visibleSupplementaryViews(
                    ofKind: UICollectionView.elementKindSectionHeader
                ).forEach { header in
                    header.stopShimmering()
                }
            }
        }
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeSpotlightCell.self, forCellWithReuseIdentifier: HomeSpotlightCell.reuseIdentifier)
        collectionView.register(HomeProductCell.self, forCellWithReuseIdentifier: HomeProductCell.reuseIdentifier)
        collectionView.register(HomeDigioCashCell.self, forCellWithReuseIdentifier: HomeDigioCashCell.reuseIdentifier)
        collectionView.register(HomeSectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier)
        collectionView.register(HomeHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HomeHeaderView.reuseIdentifier)

        view.addSubviewFillingSuperview(collectionView)
    }

}

extension HomeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
            let cell: UICollectionViewCell

            switch viewModel.sections[indexPath.section] {
            case .spotlight(let spotlights):
                guard let spotlightCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeSpotlightCell.reuseIdentifier,
                    for: indexPath
                ) as? HomeSpotlightCell else {
                    return UICollectionViewCell()
                }
                spotlightCell.configure(with: spotlights)
                cell = spotlightCell

            case .products(let products):
                guard let productCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeProductCell.reuseIdentifier,
                    for: indexPath
                ) as? HomeProductCell else {
                    return UICollectionViewCell()
                }
                productCell.configure(with: products)
                cell = productCell

            case .cash(let cash):
                guard let cashCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeDigioCashCell.reuseIdentifier,
                    for: indexPath
                ) as? HomeDigioCashCell else {
                    return UICollectionViewCell()
                }
                cashCell.configure(with: cash)
                cell = cashCell
            }

            cell.contentView.startShimmering()

            return cell
        }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 180)
        case 1:
            return CGSize(width: collectionView.bounds.width - 48, height: 100)
        case 2:
            return CGSize(width: collectionView.bounds.width, height: 150)
        default:
            return CGSize.zero
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let headerView: UICollectionReusableView

        guard let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier,
            for: indexPath
        ) as? HomeSectionHeaderView else {
            return UICollectionReusableView()
        }

        if kind == UICollectionView.elementKindSectionHeader {
            switch indexPath.section {
            case 0:
                guard let homeHeaderView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HomeHeaderView.reuseIdentifier,
                    for: indexPath
                ) as? HomeHeaderView else {
                    return UICollectionReusableView()
                }
                homeHeaderView.configure(userName: LocalizedString.homeTitle.localized)
                headerView = homeHeaderView

            case 1:
                sectionHeaderView.configure(with: LocalizedString.digioCash.localized)
                headerView = sectionHeaderView

            case 2:
                sectionHeaderView.configure(with: LocalizedString.productsSection.localized)
                headerView = sectionHeaderView

            default:
                headerView = UICollectionReusableView()
            }
            headerView.startShimmering()
            return headerView

        }
        return UICollectionReusableView()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 100)
        case 1, 2:
            return CGSize(width: collectionView.bounds.width, height: 65)
        default:
            return CGSize.zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            guard let cash = viewModel.homeData?.cash else { return }
            self.clickCell(name: cash.title, description: cash.description)
        }
    }
}

extension HomeViewController: HomeViewControllerClickDelegate {
    func clickCell(name: String, description: String) {
        self.delegate?.navigation(action: .details(name: name, description: description))
    }
}
