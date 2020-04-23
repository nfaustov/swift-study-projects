//
//  GalleryViewController.swift
//  StudyProject8
//
//  Created by Nikolai Faustov on 20.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var imageContainer: UIImageView!
    
    let images: [UIImage?] = [
        UIImage(named: "1"), UIImage(named: "2"),
        UIImage(named: "3"), UIImage(named: "4"),
        UIImage(named: "5"), UIImage(named: "6"),
        UIImage(named: "7"), UIImage(named: "8"),
        UIImage(named: "9"), UIImage(named: "10")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let actualImage = images.first {
            imageContainer.image = actualImage
        }
        
        backButton.isEnabled = false
    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func switchButton(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case ">>":
            guard let imageIndex = images.firstIndex(of: imageContainer.image) else {return}
            let nextIndex = imageIndex + 1
            guard nextIndex < images.count else {return}
            guard nextIndex > 0 else {return}
            imageContainer.image = images[nextIndex]

            backButton.isEnabled = true

            if imageIndex == images.count - 2 {
                nextButton.isEnabled = false
            }
        case "<<":
            guard let imageIndex = images.firstIndex(of: imageContainer.image) else {return}
            let previousIndex = imageIndex - 1
            guard previousIndex >= 0 else {return}
            guard images.count - 1 > previousIndex else {return}
            imageContainer.image = images[previousIndex]

            if imageIndex == 1 {
                backButton.isEnabled = false
            }
            else if imageIndex == images.count - 1 {
                nextButton.isEnabled = true
            }
        default: ()
        }
    }
}

