//
//  ApiEndpointTargetType.swift
//  Networking
//
//  Created by Jiaxin Pu on 2024/2/28.
//

import Foundation
import Moya


public enum ApiEndpointTargetType {
    case repositories(String)
}

extension ApiEndpointTargetType: TargetType {
    public var baseURL: URL {
        return .init(string: "https://api.github.com")!
    }
    
    public var path: String {
        switch self {
        case .repositories:
            return "/search/repositories"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .repositories(_):
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .repositories(let string):
            return .requestParameters(parameters: ["q": string], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}
