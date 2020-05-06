//
//  ImagesViewController.swift
//  StudyProject8
//
//  Created by Nikolai Faustov on 22.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

struct ImageDescription {
    
    let image: UIImage?
    let name: String
}

class ImagesViewController: UIViewController {

    let images: [ImageDescription] = [
        ImageDescription(image: UIImage(named: "1"), name: "Image 1"), ImageDescription(image: UIImage(named: "2"), name: "Image 2"),
        ImageDescription(image: UIImage(named: "3"), name: "Image 3"), ImageDescription(image: UIImage(named: "4"), name: "Image 4")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureObjects()
    }
    
    func configureObjects() {
        
        var x = 0
        var y = -194
        
        for (index, image) in images.enumerated() {
            if index % 2 == 0 {
                x = 6
                y += 274
            }
            else {
                x = 210
            }
            
            let label = UILabel()
            label.text = image.name
            label.frame = CGRect(x: x + 3, y: y + 185, width: 100, height: 30)
            view.addSubview(label)
            
            let imageView = UIImageView()
            imageView.image = image.image
            imageView.frame = CGRect(x: x, y: y, width: 198, height: 224)
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
        }
    }
}
