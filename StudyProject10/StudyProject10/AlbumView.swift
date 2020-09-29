//
//  AlbumView.swift
//  StudyProject10
//
//  Created by Nikolai Faustov on 09.07.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class AlbumView: UIView {

    @IBOutlet weak var albumNameLabel: UILabel!
    
    @IBOutlet weak var albumImagesStack: UIStackView!
    
    static func loadFromNIB() -> AlbumView {
        let nib = UINib(nibName: "AlbumView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! AlbumView
    }
    
    func setupAlbum(from model: Album) {
        albumNameLabel.text = model.albumName

        for image in model.imageNames.indices {
            let imageView = UIImageView(image: UIImage(named: model.imageNames[image]))
            imageView.contentMode = .scaleAspectFit
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
            
            albumImagesStack.addArrangedSubview(imageView)
        }
    }
}
