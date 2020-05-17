//
//  ViewController.swift
//  Bad Constant
//
//  Created by Nikolai Faustov on 29.03.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class CutViewController: UIViewController {
    var totalPrice = 0
    var cutPrice = 10
    var capsulationPrice = 15
    var extensionPrice = 25
    
    @IBOutlet weak var cutLabel: UILabel!
    
    @IBOutlet weak var capsulationLabel: UILabel!
    
    @IBOutlet weak var extensionLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var сutTextfield: UITextField!
    
    @IBOutlet weak var capsulationTextfield: UITextField!
    
    @IBOutlet weak var extensionTextfield: UITextField!
    
    @IBAction func total(_ sender: Any) {
        view.endEditing(true)
        
        if let cut = Int(сutTextfield.text!) {
            cutLabel.text = "\(cut * cutPrice)"
        }
        else {
            cutLabel.text = "0"
        }

        if let capsulation = Int(capsulationTextfield.text!) {
            capsulationLabel.text = "\(capsulation * capsulationPrice)"
        }
        else {
            capsulationLabel.text = "0"
        }

        if let extensionNum = Int(extensionTextfield.text!) {
            extensionLabel.text = "\(extensionNum * extensionPrice)"
        }
        else {
            extensionLabel.text = "0"
        }

        if let cutTotalPrice = Int(cutLabel.text ?? ""), let capsulationTotalPrice = Int(capsulationLabel.text ?? ""), let extensionTotalPrice = Int(extensionLabel.text ?? "") {
            totalPrice = cutTotalPrice + capsulationTotalPrice + extensionTotalPrice
            totalLabel.animate(newText: "\(totalPrice) ₽", characterDelay: 0.1)
        }
    }
    
    @IBAction func badConstant() {
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FoxViewController, segue.identifier == "ShowFoxMoney" {
            if totalPrice / 2 >= 1000 {
                vc.foxMoney = "Мои денежки: \(totalPrice / 2) ₽ 😍"
            }
            else {
                vc.foxMoney = "Мои денежки: \(totalPrice / 2) ₽ 😪"
            }
        }
    }
}


