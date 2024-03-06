//
//  LoadingProgressLine.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/3/6.
//

import UIKit
import SnapKit

class LoadingProgressLine: UIView {
    let bgColor: UIColor
    let progressColor: UIColor
    let removeWhenCompleted: Bool
    lazy var progressLine: UIView = {
        let line = UIView()
        return line
    }()
    private var progressLineWidthConstraint: Constraint?
    
    init(bgColor: UIColor = .gray, progressColor: UIColor = .cyan, removeWhenCompleted: Bool = true) {
        self.bgColor = bgColor
        self.progressColor = progressColor
        self.removeWhenCompleted = removeWhenCompleted
        super.init(frame: .zero)
        
        backgroundColor = bgColor
        progressLine.backgroundColor = progressColor
    
        addSubview(progressLine)
        progressLine.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            progressLineWidthConstraint = make.width.equalTo(0).constraint
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateProgress(_ progress: Float) {
        let lineWidth = CGFloat(progress) * bounds.size.width
        progressLineWidthConstraint?.update(offset: lineWidth)
        if removeWhenCompleted && progress >= 1 {
            removeFromSuperview()
        }
    }

}
