//
//  HomeViewModel.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import Foundation

protocol HomeViewModelProtocol {
    var homeData: HomeModel? { get }
    var sections: [HomeSection] { get }
    var updateUI: (() -> Void)? { get set }
    func fetchHomeData()
}

final class HomeViewModel: HomeViewModelProtocol {

    var homeData: HomeModel? {
        didSet {
            self.updateUI?()
        }
    }

    var updateUI: (() -> Void)?
    var sections: [HomeSection] = []

    func fetchHomeData() {
        let net = NetworkRequest()
        var updatedSections: [HomeSection] = []
        net.make(request: HomeRouter.home) { [weak self] result in
            guard let response = result.data else {
                return
            }

            do {
                let model = try JSONDecoder().decode(HomeModel.self, from: response)
                
                updatedSections = [.spotlight(model.spotlight), .cash(model.cash), .products(model.products) ]
//                if !model.spotlight.isEmpty {
//                    updatedSections.append(HomeSection.spotlight(model.spotlight))
//                   }
//                   if !model.products.isEmpty {
//                       updatedSections.append(HomeSection.products(model.products))
//                   }
//                updatedSections.append(HomeSection.cash(model.cash))
                
                DispatchQueue.main.async {
                    self?.sections = updatedSections
                    self?.homeData = model
                }
            } catch {
                print(error)
            }
        }
    }
}
