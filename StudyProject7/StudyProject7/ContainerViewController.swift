//
//  ContainerViewController.swift
//  StudyProject7
//
//  Created by Nikolai Faustov on 08.05.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    private var contentViewControllers = [UIViewController]() {
        didSet {
            assert(contentViewControllers.count <= 6, "Too much viewControllers added (max 6 allowed)")
        }
    }
    
   private var buttons = [UIButton]() {
        didSet {
            assert(buttons.count <= 6, "Too much buttons added (max 6 allowed")
        }
    }
    
    var vcStack: UIStackView!
    
    var placeholderViewController: PlaceholderViewController?
    
    var blueViewController: BlueViewController?
    var yellowViewController: YellowViewController?
    var greenViewController: GreenViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViewController(blueViewController, identifier: "Blue")
        addViewController(yellowViewController, identifier: "Yellow")
        addViewController(greenViewController, identifier: "Green")
        
        setButtonsStack(quantity: contentViewControllers.count)
        
        setPlaceholderViewContoller(placeholderVC: placeholderViewController, identifier: "Placeholder")
        
        setVCStack()
    }
    
    func setButtonsStack(quantity: Int) {
        for num in 0..<quantity {
            let button = UIButton(type: .system)
            button.setTitle("\(num + 1)", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
            button.addTarget(self, action: #selector(showContentViews), for: .touchUpInside)
            buttons.insert(button, at: num)
        }
        
        let buttonsStack = UIStackView(arrangedSubviews: buttons)
        buttonsStack.axis = .horizontal
        buttonsStack.alignment = .fill
        buttonsStack.distribution = .fillEqually
        buttonsStack.spacing = 0
        view.addSubview(buttonsStack)
        
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        buttonsStack.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        buttonsStack.heightAnchor.constraint(equalToConstant: 43).isActive = true
    }

    func addViewController(_ vc: UIViewController?, identifier: String) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        addChild(vc)
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
        vc.view.isHidden = true
            
        contentViewControllers.append(vc)
    }
    
    func setPlaceholderViewContoller(placeholderVC: UIViewController?, identifier: String) {
        let placeholderVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        addChild(placeholderVC)
        view.addSubview(placeholderVC.view)
        placeholderVC.didMove(toParent: self)

        placeholderVC.view.translatesAutoresizingMaskIntoConstraints = false
        placeholderVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -83).isActive = true
        placeholderVC.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 87).isActive = true
        placeholderVC.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func setVCStack() {
        vcStack = UIStackView()
        vcStack.axis = .vertical
        vcStack.alignment = .fill
        vcStack.distribution = .fillEqually
        vcStack.spacing = 0
        view.addSubview(vcStack)
        vcStack.isHidden = true
        
        for vc in contentViewControllers {
            vcStack.addArrangedSubview(vc.view)
        }
        
        vcStack.translatesAutoresizingMaskIntoConstraints = false
        vcStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -83).isActive = true
        vcStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 87).isActive = true
        vcStack.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private var shownContentViews: [UIView] {
        return vcStack.arrangedSubviews.filter { !$0.isHidden }
    }
    
    @objc func showContentViews(sender: UIButton) {
        for index in buttons.indices {
            if sender == buttons[index] {
                contentViewControllers[index].view.isHidden = !contentViewControllers[index].view.isHidden
                
                if shownContentViews.count > 0 {
                    vcStack.isHidden = false
                }
                else {
                    vcStack.isHidden = true
                }
                
                sender.titleLabel?.textColor == UIColor.black ? sender.setTitleColor(.systemBlue, for: .normal) : sender.setTitleColor(.black, for: .normal)
            }
        }
    }
}


