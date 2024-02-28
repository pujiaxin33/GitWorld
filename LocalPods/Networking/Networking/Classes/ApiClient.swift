
import RxSwift
import UIKit

public enum HttpError: Error {
    case serverError
    case invalidDataError(Error?)
}

public protocol ApiClient {
    func request<T: Decodable>(_ endpoint: ApiEndpoint) -> Observable<T>
}

public class StandardApiClient: ApiClient {
    private let baseUrl: String
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    public func request<T: Decodable>(_ endpoint: ApiEndpoint) -> Observable<T> {
        return .create { observer in
            observer.onError(HttpError.serverError)
            return Disposables.create {}
        }.delay(.seconds(2), scheduler: MainScheduler.asyncInstance)
    }
}
