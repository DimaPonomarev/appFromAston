//
//  NetworkService.swift
//  BettaBank
//
//  Created by Dzhami on 01.12.2023.
//

import Foundation
import Combine

final class NetworkService: NetworkServiceProtocol {
    
    func makeRequest<T>(request: String) -> AnyPublisher<T, Error> where T: Decodable {
        makeBaseRequest(url: createURLWith(request: request))
    }
}

private extension NetworkService {
    
    func createURLWith(request: String) -> URL? {
        guard let filepath = Bundle.main.path(forResource: "auth", ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: filepath)
        return url
    }
}
