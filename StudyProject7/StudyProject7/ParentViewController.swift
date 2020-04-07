//
//  ParentViewController.swift
//  StudyProject7
//
//  Created by Nikolai Faustov on 07.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
    private var ChildVC: ChildViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChildViewController, segue.identifier == "EmbededSegue" {
            ChildVC = vc
            vc.delegate = self
        }
    }
    
    @IBAction func changeColor(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Зеленый": ChildVC?.backgroundColor = .green
        case "Желтый": ChildVC?.backgroundColor = .yellow
        default: ChildVC?.backgroundColor = .purple
        }
    }
}

extension ParentViewController: ParentViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
