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
    @IBInspectable var backColor: UIColor = .systemGray3 { didSet { layoutIfNeeded() } }

    private let activeView = UIView()
    
    private lazy var leadingSpace = activeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bounds.width / CGFloat(segments) * CGFloat(activeIndex))

    private var segmentsViews = [UIView]()
    private var segmentsLabels = [UILabel]()
    
    var segments = 2 {
        didSet {
            assert(segments <= 5, "Maximum 5 segments available")
            assert(segments > 1, "You must provide at least 2 segments ")
        }
    }
    
    var activeIndex = 0 {
        didSet {
            assert(activeIndex < segments && activeIndex >= 0, "activeIndex is out of range")
        }
    }
    
    private func configure() {
        addSubview(activeView)
        
        activeView.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<segments {
            let segmentView = UIView()
            segmentView.backgroundColor = .clear
            addSubview(segmentView)
            segmentsViews.append(segmentView)

            segmentView.translatesAutoresizingMaskIntoConstraints = false
            
            let segmentLabel = UILabel()
            segmentView.addSubview(segmentLabel)
            addSubview(segmentLabel)
            segmentsLabels.append(segmentLabel)
            
            segmentLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false

        configure()

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        configure()

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        addGestureRecognizer(tap)
    }
    
    @objc func didTap(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: self)
        for (index, segment) in segmentsViews.enumerated() {
            if segment.frame.contains(location) {
                leadingSpace.constant = segment.frame.origin.x
                delegate?.didSelectSegment(index: index)
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = cornerRadius
        backgroundColor = backColor
        layer.borderColor = UIColor.systemGray3.cgColor
        layer.borderWidth = 1

        activeView.backgroundColor = activeSegmentColor
        activeView.layer.cornerRadius = cornerRadius

        leadingSpace.isActive = true
        activeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        activeView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        activeView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / CGFloat(segments)).isActive = true

        let segmentsNames = [firstSegmentName, secondSegmentName, thirdSegmentName, fourthSegmentName, fifthSegmentName]
        
        segmentsLabels.enumerated().forEach { index, label in
            label.text = segmentsNames[index]
        }

        for (index, segment) in segmentsViews.enumerated() {
            segment.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.width / CGFloat(segments) * CGFloat(index)).isActive = true
            segment.topAnchor.constraint(equalTo: topAnchor).isActive = true
            segment.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            segment.widthAnchor.constraint(equalTo: activeView.widthAnchor).isActive = true

            segmentsLabels[index].centerXAnchor.constraint(equalTo: segment.centerXAnchor).isActive = true
            segmentsLabels[index].centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

            segmentsLabels[index].text = segmentsNames[index]
        }
    }

    static func loadFromNIB() -> CustomSegmentedControl {
        let nib = UINib(nibName: "CustomSegmentedControl", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! CustomSegmentedControl
    }
}
