//
//  SquareView.swift
//  StudyProject13addition
//
//  Created by Nikolai Faustov on 21.02.2021.
//

import UIKit

class SquareView: UIView {
    private var pinchGestureAnchorScale: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemYellow
        layer.cornerRadius = 5
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        addGestureRecognizer(pinch)
        pinch.delegate = self
        
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
        addGestureRecognizer(rotation)
        rotation.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        transform = transform.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1
    }
    
    @objc private func handleRotation(_ gesture: UIRotationGestureRecognizer) {
        transform = transform.rotated(by: gesture.rotation)
        gesture.rotation = 0
    }
}

extension SquareView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
