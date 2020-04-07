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
    
    enum Operator: String {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "*"
        case quotient = "/"
        case power = "^"
        case min = "min"
        case max = "max"
        
        func apply(_ num1: Double, _ num2: Double) -> Double {
            var result: Double
            switch self {
                case .addition: result = num1 + num2
                case .subtraction: result = num1 - num2
                case .multiplication: result = num1 * num2
                case .quotient: result = num1 / num2
                case .power: result = pow(num1, num2)
                case .min: result = num1 > num2 ? num2 : num1
                case .max: result = num2 > num1 ? num1 : num2
                }
            return result
        }
    }
    
    @IBAction func calculate() {
        if let num1 = Double(num1TextField.text ?? ""), let num2 = Double(num2TextField.text ?? "") {
            if let operation = Operator(rawValue: operationTextField.text ?? "") {
            resultLabel.text = "\(operation.apply(num1, num2))"
            }
            else {
                resultLabel.text = "Введите корректный оператор"
            }
        }
        else {
            resultLabel.text = "Введите число"
        }
    }
}

