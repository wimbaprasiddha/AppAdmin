//
//  WebService.swift
//  ios-gox
//
//  Created by Willa on 04/03/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import Foundation
import Alamofire

struct AlamofireNetworkingService {
    
    func perform<T>(resource: Resource<T>, completion: @escaping (Swift.Result<T, NetworkingError>) -> Void) where T : Decodable, T : Encodable {
        
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 20
        
        Alamofire.request(resource.url, method: resource.httpMethod, parameters: resource.params, headers: resource.headers)
            .validate()
            .responseData { (response) in
                switch response.result{
                case .success(let data):
                    do{
                        completion(.success(try JSONDecoder().decode(T.self, from: data)))
                    }catch{
                        completion(.failure(NetworkingError.decodingError(error)))
                    }
                case .failure(let err):
                    completion(.failure(NetworkingError.err(err)))
                }
        }
        
    }
}



/// Resource for every networking request
struct Resource<T: Codable>{
    var url: URL
    var httpMethod: HTTPMethod
    var params: [String: String]?
    var headers: [String: String]?
    var isUserAuthHeader: Bool
    var cacheID: String?
    var data: Data?
}



enum NetworkingError: Error{
    case decodingError(Error?)
    case noNetwork(Error?)
    case noDataReceived(Error?)
    case phoneNumberIsNotVerified(Error?)
    case other(String)
    case err(Error?)
}

extension NetworkingError: LocalizedError{
    public var errorDescription: String? {
        switch self {
        case .decodingError(let err):
            return NSLocalizedString("Error: Failed to get data", comment: "\(err?.localizedDescription ?? "")")
        case .noNetwork(let err):
            return NSLocalizedString("Error: No Network", comment: "\(err?.localizedDescription ?? "")")
        case .noDataReceived(let err):
            return NSLocalizedString("Error: No Data Received", comment: "\(err?.localizedDescription ?? "")")
        case .phoneNumberIsNotVerified(_):
            return NSLocalizedString("Your phone number is not verified.", comment: "")
        case .other(let msg):
            return NSLocalizedString("\(msg)", comment: "")
        case .err(let err):
            return NSLocalizedString("\(err?.localizedDescription ?? "Failed to get data")", comment: "")
        }
    }
}

