
import RxSwift
import UIKit
import Moya

public enum HttpError: Error {
    case serverError
    case invalidDataError(Error?)
}

public protocol ApiClient {
    func request<T: Decodable>(_ endpoint: ApiEndpointTargetType) -> Observable<T>
}

public class StandardApiClient: ApiClient {
    private let baseUrl: String
    private let provider = MoyaProvider<ApiEndpointTargetType>()
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
        
    }
    
    public func request<T: Decodable>(_ endpoint: ApiEndpointTargetType) -> Observable<T> {
        return provider.rx.request(endpoint).map(T.self).asObservable()
    }
}
