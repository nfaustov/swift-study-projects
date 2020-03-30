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
    
    @IBAction func addText(_ sender: Any) {
        var enterText = [String]()
        enterText += [enterTextField.text!]
       
//        for text in enterText {
//            textLabel.text! += text + " "
//        }
        for text in enterText {
            textLabel.text! = text + " " + textLabel.text!
        }
    }
}



