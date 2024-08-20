//
//  HomeService.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 20/08/24.
//

import Foundation

protocol HomeServiceProtocol {
    func fetchHomeData(completion: @escaping (Result<HomeModel, Error>) -> Void)
}

class HomeService: HomeServiceProtocol {
    private let networkService: RequestProvider

    init(networkService: RequestProvider = NetworkRequest()) {
        self.networkService = networkService
    }

    func fetchHomeData(completion: @escaping (Result<HomeModel, Error>) -> Void) {
        networkService.make(request: HomeRouter.home) { result in
            guard let response = result.data else {
                completion(
                    .failure(
                        NSError(domain: "",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "No data found."]
                               )
                    )
                )
                return
            }

            do {
                let model = try JSONDecoder().decode(HomeModel.self, from: response)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
