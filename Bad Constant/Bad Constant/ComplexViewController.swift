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
    
    @IBOutlet weak var extButton: UIButton!
    @IBOutlet weak var cutButton: UIButton!
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    var active1: Bool = true
    var active2: Bool = true
    
    var extensionPrice = 0
    var cutPrice = 0
    var myExtMoney = 0.0
    var myCutMoney = 0.0
    
    var totalPrice = 0 {
        didSet {
            totalLabel.text = "\(extensionPrice + cutPrice) ₽"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()
        
        containerView.clipsToBounds = true
        
        bottomContainerView.layer.cornerRadius = 12
        bottomContainerView.clipsToBounds = true
    }
    
    func setupButtons() {
        extButton.layer.cornerRadius = 6
        extButton.clipsToBounds = true
        cutButton.layer.cornerRadius = 6
        cutButton.clipsToBounds = true
    }
    
    @IBAction func extButton(_ sender: UIButton) {
        if active1 {
            UIView.animate(withDuration: 0.3) {
                sender.backgroundColor = UIColor.systemGray6
            }
            configureExtViewController()
            showExtViewController(active1)
        }
        else {
            UIView.animate(withDuration: 0.3) {
                sender.backgroundColor = UIColor.systemGray4
            }
            showExtViewController(active1)
//            extensionViewController.remove()
            extensionPrice = 0
            myExtMoney = 0.0
        }
        active1 = !active1
    }
    
    @IBAction func cutButton(_ sender: UIButton) {
        if active2 {
            UIView.animate(withDuration: 0.3) {
                sender.backgroundColor = UIColor.systemGray6
            }
            configureCutViewController()
            showCutViewController(active2)
        }
        else {
            UIView.animate(withDuration: 0.3) {
                sender.backgroundColor = UIColor.systemGray4
            }
            showCutViewController(active2)
//            cutViewController.remove()
            cutPrice = 0
            myCutMoney = 0.0
        }
        active2 = !active2
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
        cutViewController.view.frame = CGRect(x: 0, y: 560, width: view.frame.width, height: 290)
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
                            self.extensionViewController.view.frame.origin.y = self.extensionViewController.view.frame.origin.y + 320
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
                            self.extensionViewController.view.frame.origin.y = self.extensionViewController.view.frame.origin.y - 320
            }) { (finished) in
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
                            self.cutViewController.view.frame.origin.y = self.cutViewController.view.frame.origin.y - 300
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
                            self.cutViewController.view.frame.origin.y = self.cutViewController.view.frame.origin.y + 300
            }) { (finished) in
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


