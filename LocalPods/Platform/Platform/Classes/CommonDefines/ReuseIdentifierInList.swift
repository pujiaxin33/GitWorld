//
//  ReuseIdentifyInList.swift
//  Platform
//
//  Created by Jiaxin Pu on 2024/2/28.
//

import UIKit

public protocol ReuseIdentifierInList {
    static var reuseIdentifier: String { get }
}

public extension ReuseIdentifierInList {
    static var reuseIdentifier: String {
         return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifierInList {}

