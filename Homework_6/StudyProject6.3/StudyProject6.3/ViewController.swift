//
//  ViewController.swift
//  StudyProject6.3
//
//  Created by Nikolai Faustov on 29.03.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var num1TextField: UITextField!
    
    @IBOutlet weak var num2TextField: UITextField!
    
    @IBOutlet weak var operationTextField: UITextField!
    
    @IBAction func calculate(_ sender: Any) {
        if let num1 = Int(num1TextField.text!), let num2 = Int(num2TextField.text!) {
            switch operationTextField.text {
            case "+": resultLabel.text = String(num1 + num2)
            case "-": resultLabel.text = String(num1 - num2)
            case "*": resultLabel.text = String(num1 * num2)
            case "/": resultLabel.text = String(format: "%.3f",Double(num1) / Double(num2))
            default: resultLabel.text = "Введите корректный оператор"
            }
        }
        else {
            resultLabel.text = "Введите целое число"
        }
    }
}

