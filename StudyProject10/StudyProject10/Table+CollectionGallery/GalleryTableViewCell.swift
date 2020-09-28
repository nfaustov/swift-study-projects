//
//  GalleryTableViewCell.swift
//  StudyProject10
//
//  Created by Nikolai Faustov on 15.07.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var albumNameLabel: UILabel!
    
    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    func setCollectionViewDataSource(dataSource: UICollectionViewDataSource, for row: Int) {
        albumCollectionView.dataSource = dataSource
        albumCollectionView.tag = row
        albumCollectionView.reloadData()
    }
    
    func setAlbumName(from model: Album) {
        albumNameLabel.text = model.albumName
    }
}
