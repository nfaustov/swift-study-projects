//
//  GalleryViewController.swift
//  StudyProject10
//
//  Created by Nikolai Faustov on 15.07.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        galleryTableView.rowHeight = 200
    }
    
    let galleryAlbums: [Album] = [
        Album(albumName: "Животные",
              imageNames: ["animal1", "animal2", "animal3", "animal4", "animal5", "animal6", "animal7", "animal8"]),
        Album(albumName: "Природа",
              imageNames: ["1", "2", "3", "4", "5", "6"]),
        Album(albumName: "Люди",
              imageNames: ["people1", "people2", "people3", "people4", "people5", "people6", "people7"]),
        Album(albumName: "Apple",
              imageNames: ["apple1", "apple2", "apple3", "apple4", "apple5", "apple6", "apple7", "apple8", "apple9"]),
        Album(albumName: "Городские пейзажи",
              imageNames: ["city1", "city2", "city3", "city4", "city5", "city6", "city7", "city8"]),
        Album(albumName: "Роботы",
              imageNames: ["robot1", "robot2", "robot3", "robot4", "robot5", "robot6"])
    ]
}

extension GalleryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleryAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Gallery Cell") as? GalleryTableViewCell {
            cell.setAlbumName(from: galleryAlbums[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let tableViewCell = cell as? GalleryTableViewCell {
            tableViewCell.setCollectionViewDataSource(dataSource: self, for: indexPath.row)
        }
    }
}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryAlbums[collectionView.tag].imageNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Album Cell", for: indexPath) as? AlbumCollectionViewCell {
            cell.setAlbumImage(from: galleryAlbums[collectionView.tag].imageNames[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}




