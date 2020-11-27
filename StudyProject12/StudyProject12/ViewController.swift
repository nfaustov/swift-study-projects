//
//  ViewController.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 26.11.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func openDefaultVC() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DefaultViewController") as? DefaultViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func openAlamofireVC() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlamofireViewController") as? AlamofireViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
