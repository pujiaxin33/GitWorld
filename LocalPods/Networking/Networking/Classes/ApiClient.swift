
import UIKit
import Moya
import Combine


public enum HttpError: Error {
    case serverError
    case invalidDataError(Error?)
    case someError(Error?)
}

public protocol ApiClient {
    func request<T: Decodable>(_ endpoint: ApiEndpointTargetType) -> AnyPublisher<T, HttpError>
}

public class StandardApiClient: ApiClient {
    private let baseUrl: String
    private let provider = MoyaProvider<ApiEndpointTargetType>()
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
        
    }
    
    public func request<T: Decodable>(_ endpoint: ApiEndpointTargetType) -> AnyPublisher<T, HttpError> {
        return provider.requestPublisher(endpoint).map(T.self).mapError { HttpError.someError($0) }.eraseToAnyPublisher()
//        provider.rx.request(endpoint).map(T.self).asObservable()
    }
}
