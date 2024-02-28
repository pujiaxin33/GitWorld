//
//  ResponseWrapper.swift
//  Networking
//
//  Created by Jiaxin Pu on 2024/2/23.
//

import Foundation

struct ResponseWrapper<T: Decodable>: Decodable {
    let data: T
    let code: Int
    let message: String?
}
