//
//  BaseViewController.swift
//  Platform
//
//  Created by Jiaxin Pu on 2024/1/30.
//

import UIKit

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}

