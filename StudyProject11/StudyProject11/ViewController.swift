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
    
    @IBOutlet weak var timeButton: CustomButtonView!
    
    var active = false {
        didSet {
            buttonLabel = active ? "Stop clock" : "Show current time"
        }
    }
    
    var buttonLabel = ""
    
    let segmentedControl = CustomSegmentedControl.loadFromNIB()
    
    var landscape: [NSLayoutConstraint]?
    var portrait: [NSLayoutConstraint]?
    
    var isPortrait = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(segmentedControl)
        
        portrait = [
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            segmentedControl.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        landscape = [
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            segmentedControl.centerXAnchor.constraint(equalTo: timeButton.centerXAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        segmentedControl.delegate = self
    }
    
    @IBAction func currentTimeButton(_ sender: UIButton) {
        active.toggle()
        clockView.activate(state: active)
        sender.setTitle(buttonLabel, for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        isPortrait = UIDevice.current.orientation.isPortrait
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
            clockView.redraw()
        }
    }
}

