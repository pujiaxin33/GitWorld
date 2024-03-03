//
//  BaseViewController.swift
//  Platform
//
//  Created by Jiaxin Pu on 2024/1/30.
//

import RxSwift

public extension ObservableType {
    func mapToResult<T>(_ transform: @escaping (Element) throws -> Result<T, HttpError>) -> Observable<Result<T, HttpError>> {
        return self.map { e in
            try transform(e)
        }.catch { error in
            Observable.just(Result.failure(HttpError.someError(error)))
        }
    }
}
