//
//  ViewController.swift
//  StudyProject9
//
//  Created by Nikolai Faustov on 12.05.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class Task3ViewController: UIViewController {

    @IBOutlet weak var textHeightsConstraint: NSLayoutConstraint!
    
    @IBAction func textWrapButton() {
        if textHeightsConstraint.constant == 21 {
            textHeightsConstraint.constant = 105
        }
        else {
            textHeightsConstraint.constant = 21
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

