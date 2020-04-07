//
//  Item2ViewController.swift
//  StudyProject7
//
//  Created by Nikolai Faustov on 06.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class Item2ViewController: UIViewController {
    @IBOutlet weak var actualColorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController, segue.identifier == "ChangeColor" {
            guard let actualColor = actualColorLabel.text else {return}
            vc.colorText = actualColor
            vc.delegate = self
        }
    }
}

extension Item2ViewController: ViewControllerDelegate {
    func setColor(_ color: String) {
        actualColorLabel.text = color
    }
}
