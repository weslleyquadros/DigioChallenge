//
//  Network.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

public class Response {
    public var response: URLResponse?
    public var data: Data?
    public var error: Error?
    
    public init(response: URLResponse? = nil, data: Data? = nil, error: Error? = nil) {
        self.response = response
        self.data = data
        self.error = error
    }
}

public enum HTTPMethod: String {
    case POST
    case GET
    case PUT
    case PATCH
    case DELETE
    case OPTIONS
    case HEAD
    case TRACE
    case CONNECT
}

public protocol RouterProtocol {
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String]? { get }
    var body: Data? { get }
    var timeoutInterval: TimeInterval? { get }
    var additionalInfo: [String: Any]? { get }
}
            
public protocol RequestProvider {
    func make(request: RouterProtocol, completion: @escaping (Response) -> Void)
}


public class NetworkRequest: RequestProvider {
    
    public func make(request: RouterProtocol, completion: @escaping (Response) -> Void) {
        let url = URL(string: request.endpoint)!
        
        var urlRequest = URLRequest(url: url, timeoutInterval: request.timeoutInterval ?? 0.0)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body ?? nil

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(Response(error: error))
            } else if let data = data, let response = response as? HTTPURLResponse {
              if response.statusCode == 200 {
                  completion(Response(response: response, data: data))
              } else {
                // handle the response code
              }
            }
        }

        task.resume()
        
    }
    
}
