//
//  AlbumCollectionViewCell.swift
//  StudyProject10
//
//  Created by Nikolai Faustov on 15.07.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    
    func setAlbumImage(from imageName: String) {
        albumImageView.image = UIImage(named: imageName)
    }
}
