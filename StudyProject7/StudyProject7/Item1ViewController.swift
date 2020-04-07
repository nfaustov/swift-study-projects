//
//  Item1ViewController.swift
//  StudyProject7
//
//  Created by Nikolai Faustov on 08.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class Item1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func showBlue() {
        performSegue(withIdentifier: "ShowBlue", sender: nil)
    }
    
    @IBAction func showRed() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "RedController") {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
