//
//  TopicView.swift
//  StudyProject13addition
//
//  Created by Nikolai Faustov on 05.02.2021.
//

import UIKit

final class TopicView: UIView {
    
    override func draw(_ rect: CGRect) {
        let imageRect = CGRect(
            x: 5,
            y: 5,
            width: bounds.height - 10,
            height: bounds.height - 10
        )
        let imagePath = UIBezierPath(ovalIn: imageRect)
        
        let captionRect = CGRect(
            x: imageRect.maxX + 10,
            y: 12,
            width: bounds.width - imageRect.width - 30,
            height: bounds.height - 24
        )
        let captionPath = UIBezierPath(roundedRect: captionRect, cornerRadius: 3)
        
        UIColor.systemGray5.setFill()
        imagePath.fill()
        captionPath.fill()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
