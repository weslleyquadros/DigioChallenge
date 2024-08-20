//
//  MockNetworkService.swift
//  DigioChallengeTests
//
//  Created by Weslley Tavares de Aguiar e Quadros on 20/08/24.
//

import XCTest
@testable import DigioChallenge

class MockNetworkService: RequestProvider {
    var requested: RouterProtocol?
     var completionHandler: ((Response) -> Void)?

     // Flag para verificar se o método foi chamado
     var makeCalled = false
     
     // Método simulado
     func make(request: RouterProtocol, completion: @escaping (Response) -> Void) {
         makeCalled = true
         requested = request
         completionHandler = completion
         
         // Você pode definir uma resposta padrão para testes
         let dummyResponse = Response(data: HomeModelDummy.makeHomeModel(), statusCode: 200)
         completion(dummyResponse)
     }
    
    
    var shouldReturnError = false
    
    func fetchHomeData(completion: @escaping (Result<HomeData, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock Error"])))
        } else {
            // Assuming HomeData is a decodable model
            let mockData = HomeData(spotlight: [], products: [], cash: nil)
            completion(.success(mockData))
        }
    }
}
