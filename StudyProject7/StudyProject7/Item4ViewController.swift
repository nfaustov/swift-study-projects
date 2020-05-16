//
//  Item4ViewController.swift
//  StudyProject7
//
//  Created by Nikolai Faustov on 15.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class Item4ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var buttonsView: UIView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonsView.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        containerView.clipsToBounds = true
    }
    
    @IBAction func selector(_ sender: UIButton) {
        if sender.titleLabel?.textColor == UIColor.label {
            sender.setTitleColor(.systemBlue, for: .normal)
        }
        else {
            sender.setTitleColor(.label, for: .normal)
        }
        
        for child in self.children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        
        if button1.isOn() && button2.isOn() && button3.isOn() {
            addBlueViewController(setFrame(.topThird))
            addYellowViewController(setFrame(.middleThird))
            addGreenViewController(setFrame(.bottomThird))
        }
        else if button1.isOn() && button2.isOn() {
            addBlueViewController(setFrame(.topHalf))
            addYellowViewController(setFrame(.bottomHalf))
        }
        else if button1.isOn() && button3.isOn() {
            addBlueViewController(setFrame(.topHalf))
            addGreenViewController(setFrame(.bottomHalf))
        }
        else if button2.isOn() && button3.isOn() {
            addYellowViewController(setFrame(.topHalf))
            addGreenViewController(setFrame(.bottomHalf))
        }
        else if button1.isOn() {
            addBlueViewController(setFrame(.full))
        }
        else if button2.isOn() {
            addYellowViewController(setFrame(.full))
        }
        else if button3.isOn() {
            addGreenViewController(setFrame(.full))
        }
    }

    func addBlueViewController(_ frame: CGRect) {
        if let blueViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Blue") as? BlueViewController {
            addChild(blueViewController)
            containerView.addSubview(blueViewController.view)
            blueViewController.view.frame = frame
            blueViewController.didMove(toParent: self)
        }
    }

    func addYellowViewController(_ frame: CGRect) {
        if let yellowViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Yellow") as? YellowViewController {
            addChild(yellowViewController)
            containerView.addSubview(yellowViewController.view)
            yellowViewController.view.frame = frame
            yellowViewController.didMove(toParent: self)
        }
    }

    func addGreenViewController(_ frame: CGRect) {
        if let greenViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Green") as? GreenViewController {
            addChild(greenViewController)
            containerView.addSubview(greenViewController.view)
            greenViewController.view.frame = frame
            greenViewController.didMove(toParent: self)
        }
    }
    
    enum ContainerPortion {
        case full, topHalf, bottomHalf, topThird, middleThird, bottomThird
    }
    
    func setFrame(_ frame: ContainerPortion) -> CGRect {
        switch frame {
        case .full: return CGRect(x: 0, y: 0, width: 414, height: 726)
        case .topHalf: return CGRect(x: 0, y: 0, width: 414, height: 363)
        case .bottomHalf: return CGRect(x: 0, y: 363, width: 414, height: 363)
        case .topThird: return CGRect(x: 0, y: 0, width: 414, height: 242)
        case .middleThird: return CGRect(x: 0, y: 242, width: 414, height: 242)
        case .bottomThird: return CGRect(x: 0, y: 484, width: 414, height: 242)
        }
    }
}

extension UIButton {
    func isOn() -> Bool {
        if self.titleLabel?.textColor == UIColor.label {
            return false
        }
        else {
            return true
        }
    }
}

