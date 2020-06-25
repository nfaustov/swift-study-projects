//
//  ScrollViewController.swift
//  StudyProject10
//
//  Created by Nikolai Faustov on 04.06.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView! 
    
    @IBOutlet weak var viewToScroll: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageControl: UIPageControl!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var mapImageView: UIImageView!
    
    @IBOutlet weak var adressView: UIView!
    
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var orderButton: UIButton!
    
    let images: [UIImage] = [
    UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6")
    ].compactMap { $0 }
    
    var currentImage = 0 {
        didSet {
            imageView.image = images[currentImage]
            imageControl.currentPage = currentImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.tintColor = .white
  
        setImageView()
        
        mainView.layer.cornerRadius = 12
        
        menuButton.layer.borderWidth = 2
        menuButton.layer.borderColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        menuButton.layer.cornerRadius = 12
        
        mapImageView.layer.cornerRadius = 12
        
        adressView.layer.cornerRadius = 12
        
        createButton.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        createButton.tintColor = .white
        createButton.layer.cornerRadius = 12
        
        orderButton.layer.borderWidth = 2
        orderButton.layer.borderColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        orderButton.layer.cornerRadius = 12
        orderButton.tintColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
    }
    
    func setImageView() {
        
        imageView.image = images[currentImage]
        imageControl.numberOfPages = images.count
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .left:
                if currentImage < images.count - 1 {
                    currentImage += 1
                }
            case .right:
                if currentImage > 0 {
                    currentImage -= 1
                }
            default: ()
            }
        }
    }
 

}
