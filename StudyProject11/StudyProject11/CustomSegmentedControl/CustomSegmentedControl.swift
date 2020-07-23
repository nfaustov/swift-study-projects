//
//  CustomSegmentedControl.swift
//  StudyProject11
//
//  Created by Nikolai Faustov on 19.07.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func changeHourView(classic: Bool)
}

@IBDesignable
class CustomSegmentedControl: UIView {
    
    @IBInspectable private var cornerRadius: CGFloat = 10 
    
    @IBInspectable private var leftSegmentName: String = "Left Segment"
    @IBInspectable private var rightSegmentName: String = "Right Segment"
    
    @IBInspectable private var segmentColor: UIColor = .white
    @IBInspectable private var backColor: UIColor = .systemGray6

    @IBOutlet weak private var segmentView: UIView!

    @IBOutlet weak private var leftSegment: UIButton!
    @IBOutlet weak private var rightSegment: UIButton!
    
    @IBOutlet weak private var rightSideSegment: NSLayoutConstraint!
    @IBOutlet weak private var leftSideSegment: NSLayoutConstraint!
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    @IBAction func segmentPressed(_ sender: UIButton) {
        switch sender {
        case leftSegment:
            leftSideSegment.priority = UILayoutPriority(950)
            rightSideSegment.priority = UILayoutPriority(750)
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            delegate?.changeHourView(classic: true)
        default:
            rightSideSegment.priority = UILayoutPriority(950)
            leftSideSegment.priority = UILayoutPriority(750)
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            delegate?.changeHourView(classic: false)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        segmentView.backgroundColor = segmentColor
        
        layer.cornerRadius = cornerRadius
        segmentView.layer.cornerRadius = cornerRadius
        leftSegment.layer.cornerRadius = cornerRadius
        rightSegment.layer.cornerRadius = cornerRadius
        
        backgroundColor = backColor
        layer.borderColor = UIColor.systemGray3.cgColor
        layer.borderWidth = 1
        
        leftSegment.setTitle(leftSegmentName, for: .normal)
        rightSegment.setTitle(rightSegmentName, for: .normal)
    }

    static func loadFromNIB() -> CustomSegmentedControl {
        let nib = UINib(nibName: "CustomSegmentedControl", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! CustomSegmentedControl
    }
}
