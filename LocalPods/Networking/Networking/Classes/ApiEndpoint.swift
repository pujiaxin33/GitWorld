//
//  ApiEndpoint.swift
//  Networking
//
//  Created by Jiaxin Pu on 2024/2/23.
//

import Foundation

public enum HttpMethod {
    case get
    case post
}

public protocol ApiEndpoint {
    var method: HttpMethod { get }
    var path: String { get }
    var headers: [String: Any]? { get }
    var params: [String: Any]? { get }
}

public struct StandardApiEndpoint: ApiEndpoint {
    public let method: HttpMethod
    public let path: String
    public let headers: [String: Any]?
    public let params: [String: Any]?
    
    public init(method: HttpMethod, path: String, headers: [String : Any]?, params: [String : Any]?) {
        self.method = method
        self.path = path
        self.headers = headers
        self.params = params
    }
}
