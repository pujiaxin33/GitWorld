//
//  SettingsAboutViewModel.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/4/17.
//

import Foundation

class SettingsAboutViewModel {
    private(set) var info: String = ""
    
    func refreshInfo() {
         
        info = String(data: try! JSONSerialization.data(withJSONObject: Bundle.main.infoDictionary ?? [:], options: .prettyPrinted), encoding: .utf8)!
    }
}
