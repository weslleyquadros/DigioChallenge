//
//  HomeViewController.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

class HomeViewController: UIViewController {

    private var viewModel: HomeViewModelProtocol
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    init(viewModel: HomeViewModelProtocol = HomeViewModel()) {
        self.viewModel = viewModel
//        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()) // Temporarily initialize with a basic layout
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the actual layout here
//        collectionView.collectionViewLayout = createLayout()
        setupBindings()
        viewModel.fetchHomeData()
        setupCollectionView()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupBindings() {
        viewModel.updateUI = { [weak self] in
            self?.updateUI()
        }
    }

    private func updateUI() {
        if let data = viewModel.homeData {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
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
        collectionView.register(HomeSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier)
        collectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderView.reuseIdentifier)

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

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .spotlight(let spotlights):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSpotlightCell.reuseIdentifier, for: indexPath) as! HomeSpotlightCell
            cell.configure(with: spotlights)
            return cell

        case .products(let products):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductCell.reuseIdentifier, for: indexPath) as! HomeProductCell
            cell.configure(with: products)
            return cell

        case .cash(let cash):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeDigioCashCell.reuseIdentifier, for: indexPath) as! HomeDigioCashCell
            cell.configure(with: cash)
            return cell
        }
    }

}
    
extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.bounds.width - 48, height: 180)
        case 1:
            return CGSize(width: collectionView.bounds.width - 48, height: 90)
        case 2:
            return CGSize(width: collectionView.bounds.width - 48, height: 120)
        default:
            return CGSize.zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0, 2:
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) // Inset para carrosséis
        default:
            return UIEdgeInsets.zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Espaçamento entre os cards
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Espaçamento entre os itens na mesma linha
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier, for: indexPath) as! HomeSectionHeaderView
        switch indexPath.section {
        case 0:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeHeaderView.reuseIdentifier, for: indexPath) as! HomeHeaderView
            headerView.configure(userName: "Olá, Maria")
        case 1:
            headerView.configure(with: "digio Cash")
        case 2:
            headerView.configure(with: "Produtos")
        default:
            return UICollectionReusableView()
        }
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 100) // Altura do header
        case 1, 2:
            return CGSize(width: collectionView.bounds.width, height: 80) // Altura do header
        default:
            return CGSize(width: collectionView.bounds.width, height: 10) // Altura do header
        }
    }
}

