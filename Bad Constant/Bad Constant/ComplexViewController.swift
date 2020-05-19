//
//  ComplexViewController.swift
//  Bad Constant
//
//  Created by Nikolai Faustov on 22.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class ComplexViewController: UIViewController {

    var extensionViewController: UIViewController!
    var cutViewController: UIViewController!
    
    @IBOutlet weak var extButton: UIButton! {
        didSet { extButton.layer.cornerRadius = 6 }
    }
    @IBOutlet weak var cutButton: UIButton! {
        didSet { cutButton.layer.cornerRadius = 6 }
    }
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var containerView: UIView! {
        didSet { containerView.clipsToBounds = true}
    }
    @IBOutlet weak var bottomContainerView: UIView! {
        didSet { bottomContainerView.layer.cornerRadius = 12 }
    }
    
    @IBOutlet weak var totalLabel: UILabel!
    
    var extButtonActivate: Bool = true
    var cutButtonActivate: Bool = true
    
    var extensionPrice = 0
    var cutPrice = 0
    var myExtMoney = 0.0
    var myCutMoney = 0.0
    
    var totalPrice = 0 {
        didSet {
            totalLabel.text = "\(totalPrice) ₽"
            totalLabel.fadeTransition(0.9)
        }
    }
    
    @IBAction func extButton(_ sender: UIButton) {
        if extButtonActivate {
            UIView.animate(withDuration: 0.3) {
                sender.backgroundColor = UIColor.systemGray6
            }
            configureExtViewController()
            showExtViewController(extButtonActivate)
        }
        else {
            UIView.animate(withDuration: 0.3) {
                sender.backgroundColor = UIColor.systemGray4
            }
            showExtViewController(extButtonActivate)
            extensionPrice = 0
            myExtMoney = 0.0
        }
        extButtonActivate = !extButtonActivate
    }
    
    @IBAction func cutButton(_ sender: UIButton) {
        if cutButtonActivate {
            UIView.animate(withDuration: 0.3) {
                sender.backgroundColor = UIColor.systemGray6
            }
            configureCutViewController()
            showCutViewController(cutButtonActivate)
        }
        else {
            UIView.animate(withDuration: 0.3) {
                sender.backgroundColor = UIColor.systemGray4
            }
            showCutViewController(cutButtonActivate)
            cutPrice = 0
            myCutMoney = 0.0
        }
        cutButtonActivate = !cutButtonActivate
    }

    func configureExtViewController() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ExtView") as! ExtViewController
        extensionViewController = vc
        addChild(extensionViewController)
        containerView.addSubview(extensionViewController.view)
        extensionViewController.view.frame = CGRect(x: 0, y: -380, width: view.frame.width, height: 300)
        extensionViewController.didMove(toParent: self)
        vc.delegate = self
    }
    
    func configureCutViewController() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CutView") as! CutViewController
        cutViewController = vc
        addChild(cutViewController)
        containerView.addSubview(cutViewController.view)
        cutViewController.view.frame = CGRect(x: 0, y: 620, width: view.frame.width, height: 290)
        cutViewController.didMove(toParent: self)
        vc.delegate = self
    }
    
    func showExtViewController(_ showExt: Bool) {
        if showExt {
            // показываем controller
            UIView.animate(withDuration: 0.7,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.extensionViewController.view.frame.origin.y = self.extensionViewController.view.frame.origin.y + 340
            }) { (finished) in
            }
        }
        else {
            // убираем controller
            UIView.animate(withDuration: 0.7,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.extensionViewController.view.frame.origin.y = self.extensionViewController.view.frame.origin.y - 340
            }) { (finished) in
                self.extensionViewController.remove()
            }
        }
    }
    
    func showCutViewController(_ showCut: Bool) {
        if showCut {
            // показываем controller
            UIView.animate(withDuration: 0.7,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.cutViewController.view.frame.origin.y = self.cutViewController.view.frame.origin.y - 350
            }) { (finished) in
            }
        }
        else {
            // убираем controller
            UIView.animate(withDuration: 0.7,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.cutViewController.view.frame.origin.y = self.cutViewController.view.frame.origin.y + 350
            }) { (finished) in
                self.cutViewController.remove()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FoxViewController, segue.identifier == "ShowMyMoney" {
            let myMoney: Double = myExtMoney + myCutMoney
            if myMoney >= 1000 {
                vc.foxMoney = "Мои денежки: \(myMoney) ₽ 😍"
            }
            else {
                vc.foxMoney = "Мои денежки: \(myMoney) ₽ 😪"
            }
        }
    }
    
    @IBAction func badConstantButton() {
    }
}

extension UIViewController {
    func remove() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}

extension ComplexViewController: ComplexViewControllerDelegate {
    func setCutPayment(_ payment: Double) {
        myCutMoney = payment
    }
    
    func setCutPrice(_ price: Int) {
        cutPrice = price
        totalPrice += cutPrice
    }
}

extension ComplexViewController: ComplexViewControllerDelegate1 {
    func setExtPayment(_ payment: Double) {
        myExtMoney = payment
    }
    
    func setExtPrice(_ price: Int) {
        extensionPrice = price
        totalPrice += extensionPrice
    }
}


