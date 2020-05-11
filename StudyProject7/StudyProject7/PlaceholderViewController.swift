//
//  PlaceholderViewController.swift
//  StudyProject7
//
//  Created by Nikolai Faustov on 10.05.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class PlaceholderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func button(_ sender: UIButton) {
        if sender.titleLabel?.textColor == UIColor.label {
            sender.setTitleColor(.lightGray, for: .normal)
        }
        else {
            sender.setTitleColor(.label, for: .normal)
        }
    }

}
