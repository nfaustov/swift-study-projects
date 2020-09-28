//
//  CustomSwitch.swift
//  StudyProject11
//
//  Created by Nikolai Faustov on 21.08.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSwitch: UIView {
    
    @IBInspectable var state: Bool = false {
        didSet {
            leadingSpace.constant = state ? onStateSpace : offStateSpace
        }
    }
    
    @IBInspectable var selectorSizeRatio: CGFloat = 0.6 {
        didSet {
            assert(selectorSizeRatio >= 0.4 && selectorSizeRatio <= 0.8)
            selector.layer.cornerRadius = selectorRadius
            selector.heightAnchor.constraint(equalTo: heightAnchor, multiplier: selectorSizeRatio).isActive = true
        }
    }
    
    @IBInspectable var onLabelText: String = "ON" {
        didSet {
            onLabel.text = onLabelText
            layoutIfNeeded()
        }
    }
    @IBInspectable var onTextColor: UIColor = #colorLiteral(red: 0.09319030493, green: 0.7379360795, blue: 0.609675765, alpha: 1) {
        didSet {
            onLabel.textColor = onTextColor
        }
    }
    @IBInspectable var offLabelText: String = "OFF" {
        didSet {
            offLabel.text = offLabelText
            layoutIfNeeded()
        }
    }
    @IBInspectable var offTextColor: UIColor = UIColor.white {
        didSet {
            offLabel.textColor = offTextColor
        }
    }

    @IBInspectable var onBackgroundColor: UIColor = #colorLiteral(red: 0.2033183277, green: 0.2871201038, blue: 0.3680213094, alpha: 1) {
        didSet {
            if state {
                backgroundColor = onBackgroundColor
            }
        }
    }
    @IBInspectable var onSelectorColor: UIColor = #colorLiteral(red: 0.09319030493, green: 0.7379360795, blue: 0.609675765, alpha: 1) {
        didSet {
            if state {
                selector.backgroundColor = onSelectorColor
            }
        }
    }
    
    @IBInspectable var offBackgroundColor: UIColor = UIColor.systemGray3 {
        didSet {
            if !state {
                backgroundColor = offBackgroundColor
            }
        }
    }
    @IBInspectable var offSelectorColor: UIColor = UIColor.systemGray {
        didSet {
            if !state {
                selector.backgroundColor = offSelectorColor
            }
        }
    }
    
    private let selector = UIView()
    
    private let onLabel = UILabel()
    private let offLabel = UILabel()
    
    private var cornerRadius: CGFloat {
        return bounds.height / 2
    }
    
    private var selectorRadius: CGFloat {
        return cornerRadius * selectorSizeRatio
    }
    
    private var offStateSpace: CGFloat {
        return cornerRadius - selectorRadius
    }
    
    private var onStateSpace: CGFloat {
        return bounds.width - offStateSpace - selectorRadius * 2
    }
    
    private var leadingSpace = NSLayoutConstraint()
    
    private func setSelector() {
        addSubview(selector)
        selector.translatesAutoresizingMaskIntoConstraints = false
        leadingSpace = selector.leadingAnchor.constraint(equalTo: leadingAnchor)
        
        leadingSpace.constant = state ? onStateSpace : offStateSpace
        
        NSLayoutConstraint.activate([
            leadingSpace,
            selector.widthAnchor.constraint(equalTo: selector.heightAnchor),
            selector.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configureLabel(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: cornerRadius, weight: .bold)
        label.frame.size = CGSize.zero
        label.sizeToFit()

        let onLabelOrigin = CGPoint(x: offStateSpace, y: (bounds.height - label.frame.height) / 2)
        let offLabelOrigin = CGPoint(x: bounds.width - offStateSpace - label.frame.width, y: (bounds.height - label.frame.height) / 2)

        if label == onLabel {
            label.frame.origin = onLabelOrigin
            label.transform = state ? CGAffineTransform.identity : CGAffineTransform(scaleX: 0.1, y: 0.1).concatenating(CGAffineTransform(translationX: label.frame.width / 2, y: 0))
            label.isHidden = !state
        } else {
            label.frame.origin = offLabelOrigin
            label.transform = state ? CGAffineTransform(scaleX: 0.1, y: 0.1).concatenating(CGAffineTransform(translationX: -label.frame.width / 2, y: 0)) : CGAffineTransform.identity
            label.isHidden = state
        }
    }
    
    @objc func switchControl(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            state.toggle()
            UIView.animate(withDuration: 0.15) {
                self.selector.backgroundColor = self.state ? self.onSelectorColor : self.offSelectorColor
                self.backgroundColor = self.state ? self.onBackgroundColor : self.offBackgroundColor
                self.layoutIfNeeded()
                self.setNeedsLayout()
            }
        default: break
        }
    }
    
    private func commonInit() {
        layer.cornerRadius = cornerRadius

        addSubview(onLabel)
        addSubview(offLabel)
        setSelector()

        let tap = UITapGestureRecognizer(target: self, action: #selector(switchControl(recognizer:)))
        addGestureRecognizer(tap)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureLabel(onLabel)
        configureLabel(offLabel)
    }
}

