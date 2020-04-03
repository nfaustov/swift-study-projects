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
    
    @IBAction func calculate() {
//        if let num1 = Int(num1TextField.text ?? "0"), let num2 = Int(num2TextField.text ?? "0") {
//            switch operationTextField.text {
//            case "+": resultLabel.text = String(num1 + num2)
//            case "-": resultLabel.text = String(num1 - num2)
//            case "*": resultLabel.text = String(num1 * num2)
//            case "/": resultLabel.text = String(format: "%.3f",Double(num1) / Double(num2))
//            default: resultLabel.text = "Введите корректный оператор"
//            }
//        }
//        else {
//            resultLabel.text = "Введите целое число"
//        }
        enum Operator: String {
            case addition = "+"
            case subtraction = "-"
            case multiplication = "*"
            case quotient = "/"
            case modulo = "%"
            case power = "^"
            case min = "min"
            case max = "max"
            
            func apply(_ a: UITextField, _ b: UITextField) -> String {
                var result = ""
                if let num1 = Int(a.text ?? ""), let num2 = Int(b.text ?? "") {
                    switch self {
                    case .addition: result = String(num1 + num2)
                    case .subtraction: result = String(num1 - num2)
                    case .multiplication: result = String(num1 * num2)
                    case .quotient: result = String(format: "%.3f", Double(num1) / Double(num2))
                    case .modulo: result = String(num1 % num2)
                    case .power: result = String(pow(Double(num1), Double(num2)))
                    case .min: result = num1 > num2 ? String(num2) : String(num1)
                    case .max: result = num2 > num1 ? String(num1) : String(num2)
                    }
                }
                else if let num1 = Double(a.text ?? ""), let num2 = Double(b.text ?? "") {
                    switch self {
                    case .multiplication: result = String(num1 * num2)
                    default: result = "Введите целое число"
                    }
                }
                return result
            }
        }
        if let operation = Operator(rawValue: operationTextField.text ?? "") {
            resultLabel.text = operation.apply(num1TextField, num2TextField)
        }
        else {
            resultLabel.text = "Введите корректный оператор"
        }
    }
}

