//
//  ViewController.swift
//  StudyProject6.2
//
//  Created by Nikolai Faustov on 29.03.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBAction func exponentiation() {
        if let num = Int(numberTextField.text ?? "1") {
            textLabel.text = String(pow(2, Double(num)))
        }
        else {
            textLabel.text = "Введите целое число в строку"
        }
    }
    
}

