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
    
    @IBInspectable var cornerRadius: CGFloat = 5 { didSet { layoutIfNeeded() } }
    
    @IBInspectable var firstSegmentName: String = "First" { didSet { layoutIfNeeded() } }
    @IBInspectable var secondSegmentName: String = "Second" { didSet { layoutIfNeeded() } }
    @IBInspectable var thirdSegmentName: String = "Third" { didSet { layoutIfNeeded() } }
    @IBInspectable var fourthSegmentName: String = "Fourth" { didSet { layoutIfNeeded() } }
    @IBInspectable var fifthSegmentName: String = "Fifth" { didSet { layoutIfNeeded() } }
    
    @IBInspectable var activeSegmentColor: UIColor = .white { didSet { layoutIfNeeded() } }
    @IBInspectable var backColor: UIColor = .systemGray4 { didSet { layoutIfNeeded() } }
    
    @IBInspectable var segments: Int = 2 {
        didSet {
            layoutIfNeeded()
            assert(segments <= 5, "Maximum 5 segments available")
            assert(segments > 1, "You must provide at least 2 segments ")
        }
    }
    
    @IBInspectable var activeIndex: Int = 1 {
        didSet {
            assert(activeIndex < segments && activeIndex >= 0, "activeIndex is out of range")
        }
    }
    
    private let activeView = UIView()
    private let stackView = UIStackView()
    
    private var leadingSpace: NSLayoutConstraint?
    private lazy var leadingOffset = activeView.leadingAnchor.constraint(equalTo: leadingAnchor)
    
    private func configure() {
        layer.cornerRadius = cornerRadius
        backgroundColor = backColor
        layer.borderColor = backColor.cgColor
        layer.borderWidth = 1
        clipsToBounds = true

        activeView.backgroundColor = activeSegmentColor
        activeView.layer.cornerRadius = cornerRadius
        activeView.layer.shadowOpacity = 0.8
        activeView.layer.shadowColor = UIColor.systemGray.cgColor
        activeView.layer.shadowRadius = 15
        addSubview(activeView)
        
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

        let segmentsNames = [firstSegmentName, secondSegmentName, thirdSegmentName, fourthSegmentName, fifthSegmentName]
        
        for index in 0..<segments {
            let segmentView = UIView()
            segmentView.backgroundColor = .clear
            stackView.addArrangedSubview(segmentView)

            let segmentLabel = UILabel()
            segmentLabel.text = segmentsNames[index]
            segmentView.addSubview(segmentLabel)

            segmentLabel.translatesAutoresizingMaskIntoConstraints = false

            segmentLabel.centerXAnchor.constraint(equalTo: segmentView.centerXAnchor).isActive = true
            segmentLabel.centerYAnchor.constraint(equalTo: segmentView.centerYAnchor).isActive = true

            let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
            segmentView.addGestureRecognizer(tap)
        }
        
        leadingSpace = activeView.leadingAnchor.constraint(equalTo: stackView.arrangedSubviews[activeIndex].leadingAnchor)

        activeView.translatesAutoresizingMaskIntoConstraints = false
        leadingSpace?.isActive = true
        activeView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        activeView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        activeView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0 / CGFloat(segments), constant: 0).isActive = true
    }
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        configure()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        configure()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        layoutIfNeeded()
        leadingOffset.constant = stackView.arrangedSubviews[activeIndex].frame.origin.x
    }
    
    @objc func didTap(recognizer: UITapGestureRecognizer) {
        for (index, segment) in stackView.arrangedSubviews.enumerated() {
            if segment == recognizer.view {
                leadingSpace?.isActive = false
                leadingOffset.isActive = true
                leadingOffset.constant = segment.frame.origin.x
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
