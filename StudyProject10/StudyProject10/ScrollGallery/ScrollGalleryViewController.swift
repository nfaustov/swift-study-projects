//
//  ScrollGalleryViewController.swift
//  StudyProject10
//
//  Created by Nikolai Faustov on 09.07.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class ScrollGalleryViewController: UIViewController {
    
    @IBOutlet weak var albumsStack: UIStackView!
    
    private let albums: [Album] = [
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGallery(from: albums)
    }
 
    func setupGallery(from model: [Album]) {
        for album in model {
            let albumView = AlbumView.loadFromNIB()
            albumsStack.addArrangedSubview(albumView)
            albumView.setupAlbum(from: album)
        }
    }
}
