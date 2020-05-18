//
//  CutViewController.swift
//  Bad Constant
//
//  Created by Nikolai Faustov on 29.03.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

protocol ComplexViewControllerDelegate: AnyObject {
    func setCutPayment(_ payment: Double)
    func setCutPrice(_ price: Int)
}

class CutViewController: UIViewController {
    let cutProperties = CutPropeties()
    
    var totalPrice = 0
    var totalCutPayment = 0.0
    
    @IBOutlet weak var cutLabel: UILabel!
    @IBOutlet weak var capsulationLabel: UILabel!
    @IBOutlet weak var extensionLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var сutTextfield: UITextField!
    @IBOutlet weak var capsulationTextfield: UITextField!
    @IBOutlet weak var extensionTextfield: UITextField!
    
    @IBOutlet weak var totalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalButton.layer.cornerRadius = 6
        totalButton.clipsToBounds = true
    }
    
    weak var delegate: ComplexViewControllerDelegate?
    
    @IBAction func total(_ sender: Any) {
        view.endEditing(true)
        
        if let cut = Int(сutTextfield.text!) {
            cutLabel.text = "\(cut * cutProperties.cutPrice)"
        }
        else {
            cutLabel.text = "0"
        }

        if let capsulation = Int(capsulationTextfield.text!) {
            capsulationLabel.text = "\(capsulation * cutProperties.capsulationPrice)"
        }
        else {
            capsulationLabel.text = "0"
        }

        if let extensionNum = Int(extensionTextfield.text!) {
            extensionLabel.text = "\(extensionNum * cutProperties.extensionPrice)"
        }
        else {
            extensionLabel.text = "0"
        }

        if let cutTotalPrice = Int(cutLabel.text ?? ""), let capsulationTotalPrice = Int(capsulationLabel.text ?? ""), let extensionTotalPrice = Int(extensionLabel.text ?? "") {
            totalPrice = cutTotalPrice + capsulationTotalPrice + extensionTotalPrice
            totalCutPayment = Double(cutTotalPrice) * cutProperties.cutPaymentProportion +
                Double(capsulationTotalPrice) * cutProperties.capsulationPaymentProportion +
                Double(extensionTotalPrice) * cutProperties.extensionPaymentProportion
            
            totalLabel.animate(newText: "\(totalPrice) ₽", characterDelay: 0.1)
        }

        delegate?.setCutPrice(totalPrice)
        delegate?.setCutPayment(totalCutPayment)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
