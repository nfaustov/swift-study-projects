//
//  ViewController.swift
//  StudyProject6
//
//  Created by Nikolai Faustov on 29.03.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var enterTextField: UITextField!
    
    @IBAction func addText() {
        if let label = textLabel.text, let text = enterTextField.text {
            textLabel.text = text + " " + label
        }
    }
}


