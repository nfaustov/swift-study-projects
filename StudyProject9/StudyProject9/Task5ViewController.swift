//
//  Task5ViewController.swift
//  StudyProject9
//
//  Created by Nikolai Faustov on 24.05.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class Task5ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    var isFromBig = false
    var isToBig = false
    
    @IBAction func showImage() {
        imageView?.isHidden.toggle()
    }
    
    @IBAction func showHideBottomLabel() {
        bottomLabel?.isHidden.toggle()
    }
    
    @IBAction func showHideArrowLabel() {
        arrowLabel?.isHidden.toggle()
    }
    
    @IBAction func showHideToLabel() {
        toLabel?.isHidden.toggle()
    }

    @IBAction func updateFromLabel() {
        isFromBig.toggle()
        if isFromBig {
            fromLabel?.text = "From From From From From From From From From From From From From From From From"
        } else {
            fromLabel?.text = "From"
        }
    }
    
    @IBAction func updateToLabel() {
        isToBig.toggle()
        if isToBig {
            toLabel?.text = "To To To To To To To To To To To To To To To To To To To To To To To To To To To To To To To To To"
        } else {
            toLabel?.text = "To"
        }
    }
}
