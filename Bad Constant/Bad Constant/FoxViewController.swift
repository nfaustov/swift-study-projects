//
//  FoxViewController.swift
//  Bad Constant
//
//  Created by Nikolai Faustov on 08.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class FoxViewController: UIViewController {
    var foxMoney = ""
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyLabel.text = foxMoney
        moneyLabel.layer.cornerRadius = 6
        moneyLabel.clipsToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true, completion: nil)
    }
    
}
