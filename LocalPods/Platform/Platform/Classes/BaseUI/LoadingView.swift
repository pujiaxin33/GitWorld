//
//  LoadingView.swift
//  Platform
//
//  Created by Jiaxin Pu on 2024/2/28.
//

import Foundation
import ProgressHUD

public class LoadingView {
    public static func show(_ text: String = "Loading", interaction: Bool = true) {
        ProgressHUD.animate(text, interaction: interaction)
    }
    
    public static func hide() {
        ProgressHUD.dismiss()
    }
    
    public static func succeed(_ text: String? = nil, interaction: Bool = true, delay: TimeInterval? = nil) {
        ProgressHUD.succeed(text, interaction: interaction, delay: delay)
    }
}
