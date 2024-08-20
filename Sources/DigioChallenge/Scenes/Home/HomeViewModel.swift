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
    var onSuccess: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    func fetchHomeData()
}

final class HomeViewModel: HomeViewModelProtocol {

    private let service: HomeServiceProtocol

    var homeData: HomeModel?
    var onSuccess: (() -> Void)?
    var onError: ((Error) -> Void)?
    var sections: [HomeSection] = []

    init(networkService: HomeServiceProtocol = HomeService()) {
        self.service = networkService
    }

    func fetchHomeData() {
        var updatedSections: [HomeSection] = []
        service.fetchHomeData { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let model):
                updatedSections = [.spotlight(model.spotlight),
                                   .cash(model.cash),
                                   .products(model.products)]

                DispatchQueue.main.async {
                    self.sections = updatedSections
                    self.homeData = model
                    self.onSuccess?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.onError?(error)
                }
            }
        }
    }

}
