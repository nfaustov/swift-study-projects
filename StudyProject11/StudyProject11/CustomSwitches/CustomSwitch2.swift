//
//  CustomSwitch2.swift
//  StudyProject11
//
//  Created by Nikolai Faustov on 09.09.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSwitch2: UIView {
    
    enum State {
        case on
        case off
    }
    
    var state = false {
        didSet {
            leadingSpace.constant = state ? bounds.width - selector.frame.width : 0
        }
    }
    
    var onText = "ON"
    var offText = "OFF"
    
    var onImage = UIImage(systemName: "checkmark")
    var offImage = UIImage(systemName: "xmark")
    
    var onBackgrondColor = #colorLiteral(red: 0.2033183277, green: 0.2871201038, blue: 0.3680213094, alpha: 1)
    var onSelectorColor = #colorLiteral(red: 0.09319030493, green: 0.7379360795, blue: 0.609675765, alpha: 1)
    var onLabelColor = #colorLiteral(red: 0.09319030493, green: 0.7379360795, blue: 0.609675765, alpha: 1)
    
    var offBackgroundColor = UIColor.systemGray3
    var offSelectorColor = UIColor.systemGray
    var offLabelColor = UIColor.white
    
    private let selector = UIView()
    
    private let onStateView = UIView()
    private let offStateView = UIView()
    
    private var leadingSpace = NSLayoutConstraint()
    
    private func setSelector() {
        addSubview(selector)
        
        selector.backgroundColor = state ? onSelectorColor : offSelectorColor
        
        selector.translatesAutoresizingMaskIntoConstraints = false
        leadingSpace = selector.leadingAnchor.constraint(equalTo: leadingAnchor)
        leadingSpace.constant = state ? bounds.width * 0.67 : 0
        
        NSLayoutConstraint.activate([
            selector.topAnchor.constraint(equalTo: topAnchor),
            leadingSpace,
            selector.bottomAnchor.constraint(equalTo: bottomAnchor),
            selector.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33)
        ])
    }
    
    private func configureStateView(image: UIImage, for state: State) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        imageView.preferredSymbolConfiguration = .init(pointSize: bounds.height / 2, weight: .bold)
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.67)
        ])
        
        switch state {
        case .on:
            imageView.tintColor = onLabelColor
            imageView.trailingAnchor.constraint(equalTo: selector.leadingAnchor).isActive = true
        case .off:
            imageView.tintColor = offLabelColor
            imageView.leadingAnchor.constraint(equalTo: selector.trailingAnchor).isActive = true
        }
    }
    
    private func configureStateView(text: String, for state: State) {
        let labelView = UIView()
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: bounds.height / 2, weight: .bold)
        label.text = text
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.baselineAdjustment = .alignCenters
        addSubview(labelView)
        labelView.addSubview(label)
        
        labelView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: topAnchor),
            labelView.bottomAnchor.constraint(equalTo: bottomAnchor),
            labelView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.67),
            label.widthAnchor.constraint(lessThanOrEqualTo: labelView.widthAnchor),
            label.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: labelView.centerXAnchor)
        ])
        
        switch state {
        case .on:
            label.textColor = onLabelColor
            labelView.trailingAnchor.constraint(equalTo: selector.leadingAnchor).isActive = true
        case .off:
            label.textColor = offLabelColor
            labelView.leadingAnchor.constraint(equalTo: selector.trailingAnchor).isActive = true
        }
    }
    
    @objc func switchControl(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            state.toggle()
            UIView.animate(withDuration: 0.2) {
                self.backgroundColor = self.state ? self.onBackgrondColor : self.offBackgroundColor
                self.selector.backgroundColor = self.state ? self.onSelectorColor : self.offSelectorColor
                self.layoutIfNeeded()
            }
        default: break
        }
    }
    
    private func commonInit() {
        layer.cornerRadius = 6
        clipsToBounds = true
        backgroundColor = state ? onBackgrondColor : offBackgroundColor
        
        setSelector()
        configureStateView(text: offText, for: .off)
        configureStateView(image: onImage ?? UIImage(), for: .on)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchControl(recognizer:)))
        addGestureRecognizer(tap)
    }
    
    override func awakeFromNib() {
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        commonInit()
    }
    
}
