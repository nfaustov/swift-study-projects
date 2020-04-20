//
//  GreenViewController.swift
//  StudyProject7
//
//  Created by Nikolai Faustov on 15.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class GreenViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func button(_ sender: UIButton) {
        if sender.titleLabel?.textColor == UIColor.darkText {
            sender.setTitleColor(.lightGray, for: .normal)
        }
        else {
            sender.setTitleColor(.darkText, for: .normal)
        }
    }
}
