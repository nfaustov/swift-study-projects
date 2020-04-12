//
//  ViewController.swift
//  StudyProject7
//
//  Created by Nikolai Faustov on 31.03.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate: AnyObject {
    func setColor(_ color: String)
}

class ViewController: UIViewController {
    var colorText = ""
    
    weak var delegate: ViewControllerDelegate?
    
    @IBOutlet weak var colorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorLabel.text = colorText
    }
    
    @IBAction func changeColor(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Выбрать зеленый": colorText = "Выбран зеленый"
        case "Выбрать синий": colorText = "Выбран синий"
        default: colorText = "Выбран красный"
        }
        dismiss(animated: true, completion: nil)
        delegate?.setColor(colorText)
    }
}

