//
//  CustomSegmentedControl.swift
//  StudyProject11
//
//  Created by Nikolai Faustov on 01.08.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func didSelectSegment(index: Int)
}

@IBDesignable
class CustomSegmentedControl: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            layer.cornerRadius = cornerRadius
            activeView.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var activeSegmentColor: UIColor = .white {
        didSet {
            activeView.backgroundColor = activeSegmentColor
        }
    }
    
    @IBInspectable var backColor: UIColor = .systemGray4 {
        didSet {
            backgroundColor = backColor
            layer.borderColor = backColor.cgColor
        }
    }
    
    @IBInspectable var firstSegmentName: String = "First" {
        didSet {
            firstSegmentLabel.text = firstSegmentName
        }
    }
    
    @IBInspectable var secondSegmentName: String = "Second" {
        didSet {
            secondSegmentLabel.text = secondSegmentName
        }
    }
    
    @IBInspectable var thirdSegmentName: String = "Third" {
        didSet {
            thirdSegmentLabel.text = thirdSegmentName
        }
    }
    
    @IBInspectable var fourthSegmentName: String = "Fourth" {
        didSet {
            fourthSegmentLabel.text = fourthSegmentName
        }
    }
    
    @IBInspectable var fifthSegmentName: String = "Fifth" {
        didSet {
            fifthSegmentLabel.text = fifthSegmentName
        }
    }
    
    @IBInspectable var segments: Int = 2 {
        didSet {
            assert(segments <= 5, "Maximum 5 segments available")
            assert(segments > 1, "You must provide at least 2 segments ")
            
            stackView.arrangedSubviews.forEach {$0.removeFromSuperview()}
            setSegments()
        }
    }
    
    @IBInspectable var activeIndex: Int = 0 {
        didSet {
            assert(activeIndex < segments && activeIndex >= 0, "activeIndex is out of range")
            
            NSLayoutConstraint.deactivate(activeViewConstraints)
            setActiveViewConstraints(for: activeIndex)
        }
    }
    
    private var firstSegmentLabel = UILabel()
    private var secondSegmentLabel = UILabel()
    private var thirdSegmentLabel = UILabel()
    private var fourthSegmentLabel = UILabel()
    private var fifthSegmentLabel = UILabel()
    
    private lazy var segmentLabels = [firstSegmentLabel, secondSegmentLabel, thirdSegmentLabel, fourthSegmentLabel, fifthSegmentLabel]
    
    private let activeView = UIView()
    private let stackView = UIStackView()
    
    private var activeViewConstraints = [NSLayoutConstraint]()
    
    private func setActiveViewConstraints(for index: Int) {
        for i in stackView.arrangedSubviews.indices {
            if i == index {
                let segment = stackView.arrangedSubviews[index]
                activeViewConstraints = [
                    activeView.topAnchor.constraint(equalTo: segment.topAnchor),
                    activeView.leadingAnchor.constraint(equalTo: segment.leadingAnchor),
                    activeView.trailingAnchor.constraint(equalTo: segment.trailingAnchor),
                    activeView.bottomAnchor.constraint(equalTo: segment.bottomAnchor)
                ]
                NSLayoutConstraint.activate(activeViewConstraints)
            }
        }
    }
    
    private func configure() {
        layer.borderWidth = 1
        clipsToBounds = true

        activeView.layer.shadowOpacity = 0.8
        activeView.layer.shadowColor = UIColor.systemGray.cgColor
        activeView.layer.shadowRadius = 15
        addSubview(activeView)
        activeView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        setSegments()
    }
    
    private func setSegments() {
        for index in 0..<segments {
            let segmentView = UIView()
            segmentView.backgroundColor = .clear
            stackView.addArrangedSubview(segmentView)

            let segmentLabel = segmentLabels[index]
            segmentView.addSubview(segmentLabel)

            segmentLabel.translatesAutoresizingMaskIntoConstraints = false

            segmentLabel.centerXAnchor.constraint(equalTo: segmentView.centerXAnchor).isActive = true
            segmentLabel.centerYAnchor.constraint(equalTo: segmentView.centerYAnchor).isActive = true

            let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
            segmentView.addGestureRecognizer(tap)
        }
    }
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    @objc func didTap(recognizer: UITapGestureRecognizer) {
        for (index, segment) in stackView.arrangedSubviews.enumerated() {
            if segment == recognizer.view {
                activeIndex = index
                delegate?.didSelectSegment(index: index)
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    
    static func loadFromNIB() -> CustomSegmentedControl {
        let nib = UINib(nibName: "CustomSegmentedControl", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! CustomSegmentedControl
    }
}
