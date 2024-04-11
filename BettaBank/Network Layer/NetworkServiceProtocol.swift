//
//  NetworkServiceProtocol.swift
//  BettaBank
//
//  Created by Dzhami on 01.12.2023.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func makeRequest<T: Decodable>(request: String) -> AnyPublisher<T, Error>
}

extension NetworkServiceProtocol {
    
    func makeBaseRequest<T: Decodable>(url: URL?) -> AnyPublisher<T, Error> {
        guard let urlRequest = makeURLReqest(url: url) else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: urlRequest) .tryMap { data, _ in
            return try self.decodeJson(type: T.self, from: data)
        }
        .mapError {  error in
            return error
        }
        .eraseToAnyPublisher()
    }
    
    func makeURLReqest(url: URL?) -> URLRequest? {
        guard let url else { return nil }
        return URLRequest(url: url)
    }
    
    func decodeJson<T: Decodable>(type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try decoder.decode(type.self, from: data)
        } catch {
            throw error
        }
    }
}
