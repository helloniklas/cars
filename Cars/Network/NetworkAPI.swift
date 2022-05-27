//
//  NetworkAPI.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import Combine
import SwiftUI

struct NetworkAPI: Networkable {

    
    // MARK: Enums
    enum Error: LocalizedError, Identifiable {
        var id: String { localizedDescription }

        case serverError
        case parseError
        
        var errorDescription: String? {
            switch self {
            case .serverError:
                return "There was a problem reaching the server. Please try again"
            case .parseError:
                return "There was a problem. Please try again"
            }
        }
    }
    
    // MARK: Private Enums
    private enum Method: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
        case patch = "PATCH"
        case put = "PUT"
    }
    
    private enum EndPoint {
        static let baseURL = URL(string: "https://mcuapi.mocklab.io")!
        
        case search
        
        var url: URL {
            switch self {
            case .search:
                return EndPoint.baseURL.appendingPathComponent("/searchh")
            }
        }
        
        static func request(with url: URL, method: Method, params: [String: Any]? = nil) -> URLRequest {
            var components = URLComponents(string: url.absoluteString)!
            if method == .get || method == .delete || method == .patch {
                if let params = params {
                    components.queryItems = params.map {
                        URLQueryItem(name: $0.key, value: String(describing: $0.value))
                    }
                }
            }
            var request = URLRequest(url: components.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
            request.httpMethod = method.rawValue
            if let params = params {
                switch method {
                case .post, .patch, .put:
                    request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
                default:
                    break
                }
            }
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }
    }
    
    // MARK: Private properties
    private let decoder = JSONDecoder()
    private let urlSession = URLSession.shared
    
    // MARK: Methods
    func fetchUsedCar(make: String, model: String, year: String) -> AnyPublisher<[UsedCar], Error> {
        URLSession.shared.dataTaskPublisher(for: EndPoint.request(with: EndPoint.search.url, method: .get, params: ["make": make, "model": model, "year": year]))
            .map { return $0.data }
            .decode(type: SearchResponse.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return Error.serverError
                default:
                    return Error.parseError
                }
            }
            .compactMap { $0.searchResults }
            .eraseToAnyPublisher()
    }
    
    struct SearchResponse: Decodable {
        var searchResults: [UsedCar]?
    }
    
}
