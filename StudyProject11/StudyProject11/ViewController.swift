//
//  ViewController.swift
//  StudyProject11
//
//  Created by Nikolai Faustov on 18.07.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var clockView: ClockView!
    
    @IBOutlet weak var showTimeButton: CustomButtonView!
    
    var active = false {
        didSet {
            buttonLabel = active ? "Stop clock" : "Show current time"
        }
    }
    
    var buttonLabel = ""
    
    var portrait: [NSLayoutConstraint]?
    var landscape: [NSLayoutConstraint]?
    
    var isPortrait: Bool {
        return traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .compact
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segmentedControl = CustomSegmentedControl.loadFromNIB()
        view.addSubview(segmentedControl)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        portrait = [
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ]
        
        landscape = [
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            segmentedControl.centerXAnchor.constraint(equalTo: showTimeButton.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: showTimeButton.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(isPortrait ? portrait! : landscape!)
        
        segmentedControl.delegate = self
    }
    
    @IBAction func currentTimeButton(_ sender: UIButton) {
        active.toggle()
        clockView.activate(state: active)
        sender.setTitle(buttonLabel, for: .normal)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if isPortrait {
            NSLayoutConstraint.deactivate(landscape!)
            NSLayoutConstraint.activate(portrait!)
        } else {
            NSLayoutConstraint.deactivate(portrait!)
            NSLayoutConstraint.activate(landscape!)
        }
    }
}

extension ViewController: CustomSegmentedControlDelegate {
    func didSelectSegment(index: Int) {
        if clockView.classicView != (index % 2 == 0) {
            UIView.transition(with: clockView,
                              duration: 0.5,
                              options: clockView.classicView ? [.transitionFlipFromLeft] : [.transitionFlipFromRight],
                              animations: {self.clockView.classicView = (index % 2 == 0)}
            )
            for subview in clockView.subviews {
                subview.removeFromSuperview()
            }
            clockView.initialize()
        }
    }
}

