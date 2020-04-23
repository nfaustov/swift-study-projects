//
//  SegmentedViewController.swift
//  StudyProject8
//
//  Created by Nikolai Faustov on 23.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class SegmentedViewController: UIViewController {
    
    let segmentedControl = UISegmentedControl(items: ["1", "2", "3"]) 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureSegmentedControl()
    }
    
    func configureSegmentedControl() {
        segmentedControl.frame = CGRect(x: 20, y: 70, width: 374, height: 40)
        segmentedControl.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        segmentedControl.selectedSegmentTintColor = UIColor.red.withAlphaComponent(0.7)
        segmentedControl.addTarget(self, action: #selector(segmentedControlSwitch), for: .valueChanged)
        view.addSubview(segmentedControl)
    }
 
    @objc func segmentedControlSwitch(segment: UISegmentedControl) {
        updateView()
        
        switch segment.selectedSegmentIndex {
        case 0: configureFirstView()
        case 1: configureSecondView()
        case 2: configureThirdView()
        default: ()
        }
    }
    
    func configureFirstView() {
        let textField1 = UITextField()
        textField1.backgroundColor = .white
        textField1.frame = CGRect(x: 10, y: 10, width: 200, height: 40)
        textField1.placeholder = "TextField"
        textField1.layer.cornerRadius = 6
        
        let textField2 = UITextField()
        textField2.backgroundColor = .white
        textField2.frame = CGRect(x: 10, y: 60, width: 200, height: 40)
        textField2.placeholder = "TextField"
        textField2.layer.cornerRadius = 6
        
        let greenView = UIView()
        greenView.backgroundColor = .systemGreen
        greenView.frame = CGRect(x: 20, y: 150, width: 374, height: 110)
        greenView.layer.cornerRadius = 6
        view.addSubview(greenView)
        greenView.addSubview(textField1)
        greenView.addSubview(textField2)
    }
    
    func configureSecondView() {
        let button1 = UIButton(type: .system)
        button1.setTitle("button1", for: .normal)
        button1.setTitleColor(.black, for: .normal)
        button1.backgroundColor = .white
        button1.frame = CGRect(x: 10, y: 10, width: 140, height: 40)
        button1.layer.cornerRadius = 6
        
        let button2 = UIButton(type: .system)
        button2.setTitle("button2", for: .normal)
        button2.setTitleColor(.black, for: .normal)
        button2.backgroundColor = .white
        button2.frame = CGRect(x: 10, y: 60, width: 140, height: 40)
        button2.layer.cornerRadius = 6
        
        let blueView = UIView()
        blueView.backgroundColor = .systemBlue
        blueView.frame = CGRect(x: 20, y: 150, width: 374, height: 110)
        blueView.layer.cornerRadius = 6
        view.addSubview(blueView)
        blueView.addSubview(button1)
        blueView.addSubview(button2)
    }
    
    func configureThirdView() {
        let images: [UIImage?] = [UIImage(named: "5"), UIImage(named: "6")]
        
        let imageView1 = UIImageView()
        imageView1.image = images[0]
        imageView1.frame = CGRect(x: 12, y: 10, width: 350, height: 210)
        
        let imageView2 = UIImageView()
        imageView2.image = images[1]
        imageView2.frame = CGRect(x: 12, y: 230, width: 350, height: 210)
        
        let purpleView = UIView()
        purpleView.backgroundColor = .purple
        purpleView.frame = CGRect(x: 20, y: 150, width: 374, height: 450)
        purpleView.layer.cornerRadius = 6
        view.addSubview(purpleView)
        purpleView.addSubview(imageView1)
        purpleView.addSubview(imageView2)
    }
    
    func updateView() {
        for subview in view.subviews {
            if subview != segmentedControl {
            subview.removeFromSuperview()
            }
        }
    }
}
