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
    
    var displayLink: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segmentedControl = CustomSegmentedControl.loadFromNIB()
        segmentedControl.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 50)
        view.addSubview(segmentedControl)
        segmentedControl.delegate = self
    }
    
    @IBAction func currentTimeButton() {
        displayLink = CADisplayLink(target: clockView as ClockView, selector: #selector(clockView.currentTime))
        displayLink?.add(to: .current, forMode: .default)
    }
}

extension ViewController: CustomSegmentedControlDelegate {
    func changeHourView(classic: Bool) {
        if clockView.classicView != classic {
            UIView.transition(with: clockView,
                              duration: 0.5,
                              options: clockView.classicView ? [.transitionFlipFromLeft] : [.transitionFlipFromRight],
                              animations: {self.clockView.classicView = classic}
            )
            for subview in clockView.subviews {
                subview.removeFromSuperview()
            }
        }
    }
}

