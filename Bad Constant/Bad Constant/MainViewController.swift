//
//  MainViewController.swift
//  Bad Constant
//
//  Created by Nikolai Faustov on 04.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

extension UILabel {
    func animate(newText: String, characterDelay: TimeInterval) {
        DispatchQueue.main.async {
            self.text = ""
            for (index, character) in newText.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                    self.text?.append(character)
                    self.fadeTransition(characterDelay) 
                }
            }
        }
    }
}

class MainViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if hour >= 22 || hour < 5 {
            helloLabel.text = "Доброй ночи!"
        }
        else if hour >= 17 {
            helloLabel.text = "Добрый вечер!"
        }
        else if hour >= 11 {
            helloLabel.text = "Добрый день!"
        }
        else {
            helloLabel.text = "Доброе утро!"
        }
        helloLabel.fadeTransition(0.9)
    }
}
