//
//  ExtViewController.swift
//  Bad Constant
//
//  Created by Nikolai Faustov on 04.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

protocol ComplexViewControllerDelegate1: AnyObject {
    func setExtPayment(_ payment: Double)
    func setExtPrice(_ price: Int)
}

class ExtViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let extProperties = ExtProperties()
    let cutProperties = CutPropeties()
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var extensionTextfield: UITextField!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var supposedPriceLabel: UILabel!
    
    @IBOutlet weak var totalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        
        totalButton.layer.cornerRadius = 6
        totalButton.clipsToBounds = true
    }
    
    weak var delegate: ComplexViewControllerDelegate1?

    let colors = ["Темные неокрашенные", "Шоколад неокрашенные", "Русые/Блонд/Амбре"]
    let length = ["40-45", "50-55", "60-65", "70-75", "80-85"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return colors.count
        }
        else {
            return length.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return colors[row]
        }
        else {
            return length[row]
        }
    }
    
    func priceList(_ color: String, _ length: String) -> Int {
        let result: Int
        
        if let extensionNum = Int(extensionTextfield.text ?? "") {
            if pickerView.selectedRow(inComponent: 0) == 0 {
                switch pickerView.selectedRow(inComponent: 1) {
                case 0: result = 100
                case 1: result = 110
                case 2: result = 120
                case 3: result = 130
                case 4: result = 140
                default: result = 0
                }
            }
            else if pickerView.selectedRow(inComponent: 0) == 1 {
                switch pickerView.selectedRow(inComponent: 1) {
                case 0: result = 110
                case 1: result = 115
                case 2: result = 125
                case 3: result = 135
                case 4: result = 145
                default: result = 0
                }
            }
            else {
                switch pickerView.selectedRow(inComponent: 1) {
                case 0: result = 120
                case 1: result = 125
                case 2: result = 130
                case 3: result = 140
                case 4: result = 150
                default: result = 0
                }
            }
            return result * extensionNum
        }
        else {
            return 0
        }
    }
    
    @IBAction func evaluate() {
        priceLabel.animate(newText: "\(priceList(colors[pickerView.selectedRow(inComponent: 0)], length[pickerView.selectedRow(inComponent: 1)])) ₽", characterDelay: 0.1)
        
        delegate?.setExtPrice(priceList(colors[pickerView.selectedRow(inComponent: 0)], length[pickerView.selectedRow(inComponent: 1)]))
        
        if let extensionNum = Int(extensionTextfield.text ?? "") {
            supposedPriceLabel.text = "Предварительная стоимость коррекции: \(extensionNum * cutProperties.summaryCutPrice) ₽"
            supposedPriceLabel.fadeTransition(0.9)
            
            delegate?.setExtPayment(Double(extensionNum) * extProperties.extensionPayment)
        }
        
        extensionTextfield.resignFirstResponder()
    }
}
