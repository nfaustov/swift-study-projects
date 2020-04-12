//
//  ChildViewController.swift
//  StudyProject7
//
//  Created by Nikolai Faustov on 07.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

protocol ParentViewControllerDelegate: AnyObject {
    func setColor(_ color: UIColor)
}

class ChildViewController: UIViewController {
    var backgroundColor = UIColor.white {
        didSet {view.backgroundColor = backgroundColor}
    }
    
    weak var delegate: ParentViewControllerDelegate?
    
    @IBAction func changeColor(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Зеленый": delegate?.setColor(.green)
        case "Желтый": delegate?.setColor(.yellow)
        default: delegate?.setColor(.purple)
        }
    }
}


