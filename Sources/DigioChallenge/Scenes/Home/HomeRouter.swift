//
//  HomeRouter.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import Foundation

internal enum HomeRouter: RouterProtocol {

    case home

    var method: HTTPMethod {
        switch self {
        case .home:
            return .GET
        }
    }

    var endpoint: String {
        switch self {
        case .home:
            return "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products"
        }
    }

    var headers: [String: String]? {
        return nil
    }

    var body: Data? {
        return nil
    }

    var timeoutInterval: TimeInterval? {
        switch self {
        case .home:
            return 10.0
        }
    }

    var additionalInfo: [String: Any]? {
        return nil
    }

}
