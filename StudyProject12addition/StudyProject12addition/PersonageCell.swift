//
//  PersonageCell.swift
//  StudyProject12addition
//
//  Created by Nikolai Faustov on 14.01.2021.
//

import UIKit

class PersonageCell: UICollectionViewCell {
    static let reuseIdentifier = "PersonageCell"
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    func configure(from personage: Personage) {
        avatarImageView.load(url: personage.image)

        nameLabel.text = "Name: \(personage.name)"
        speciesLabel.text = "Species: \(personage.species)"
        genderLabel.text = "Gender: \(personage.gender)"
        statusLabel.text = "Status: \(personage.status)"
        originLabel.text = "Origin: \(personage.origin.name)"
        locationLabel.text = "Location: \(personage.location.name)"
    }
}
