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

    var homeData: HomeModel?
    var onSuccess: (() -> Void)?
    var onError: ((Error) -> Void)?
    var sections: [HomeSection] = []

    func fetchHomeData() {
        let net = NetworkRequest()
        var updatedSections: [HomeSection] = []
        net.make(request: HomeRouter.home) { [weak self] result in
            guard let self = self else { return }

            guard let response = result.data else {
                DispatchQueue.main.async {
                    self.onError?(
                        NSError(
                            domain: "",
                            code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "Failed to load data."]
                        )
                    )
                }
                return
            }

            do {
                let model = try JSONDecoder().decode(HomeModel.self, from: response)
                updatedSections = [.spotlight(model.spotlight),
                                   .cash(model.cash),
                                   .products(model.products)]

                DispatchQueue.main.async {
                    self.sections = updatedSections
                    self.homeData = model
                    self.onSuccess?()
                }
            } catch {
                DispatchQueue.main.async {
                    self.onError?(error)
                }
            }
        }
    }
}
