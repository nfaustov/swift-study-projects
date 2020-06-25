//
//  SettingsTableViewCell.swift
//  StudyProject10
//
//  Created by Nikolai Faustov on 04.06.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var settingsImage: UIImageView!
    
    @IBOutlet weak var settingsName: UILabel!
    
    var textStatusLabel: UILabel?
    
    var imageStatusView: UIImageView?
    
    var switchView: UISwitch?
    
    func configureView(fromModel cellModel: Cell) {
        
        accessoryType = .disclosureIndicator
        separatorInset.left = settingsName.frame.origin.x
        
        settingsImage.image = UIImage(systemName: cellModel.imageName)
        settingsImage.layer.cornerRadius = 6
        settingsImage.contentMode = .center
        settingsImage.tintColor = .white
        settingsImage.backgroundColor = cellModel.color
        
        settingsImage.translatesAutoresizingMaskIntoConstraints = false
        settingsImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
        settingsImage.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        settingsImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        settingsImage.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        settingsName.text = cellModel.name
        
        settingsName.translatesAutoresizingMaskIntoConstraints = false
        settingsName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
        settingsName.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        settingsName.leadingAnchor.constraint(equalTo: settingsImage.trailingAnchor, constant: 15).isActive = true
        
        if cellModel.textStatus != nil {
            textStatusLabel = UILabel()
            textStatusLabel?.text = cellModel.textStatus
            textStatusLabel?.textColor = .systemGray
            addSubview(textStatusLabel!)
            
            textStatusLabel?.translatesAutoresizingMaskIntoConstraints = false
            textStatusLabel?.bottomAnchor.constraint(equalTo: settingsName.bottomAnchor).isActive = true
            textStatusLabel?.topAnchor.constraint(equalTo: settingsName.topAnchor).isActive = true
            textStatusLabel?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
            
            settingsName.trailingAnchor.constraint(greaterThanOrEqualTo: textStatusLabel!.leadingAnchor, constant: 10).isActive = true
        } else {
            settingsName.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 10).isActive = true
        }
        
        if cellModel.imageStatusName != nil {
            imageStatusView = UIImageView(image: UIImage(systemName: cellModel.imageStatusName!))
            imageStatusView?.tintColor = .systemRed
            addSubview(imageStatusView!)
            
            imageStatusView?.translatesAutoresizingMaskIntoConstraints = false
            imageStatusView?.bottomAnchor.constraint(equalTo: settingsImage.bottomAnchor).isActive = true
            imageStatusView?.topAnchor.constraint(equalTo: settingsImage.topAnchor).isActive = true
            imageStatusView?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
            imageStatusView?.widthAnchor.constraint(equalToConstant: 28).isActive = true

            settingsName.trailingAnchor.constraint(greaterThanOrEqualTo: imageStatusView!.leadingAnchor, constant: 10).isActive = true
        } else {
            settingsName.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 10).isActive = true
        }
        
        if cellModel.switchOption {
            switchView = UISwitch()
            switchView?.isOn = false
            addSubview(switchView!)

            switchView?.translatesAutoresizingMaskIntoConstraints = false
            switchView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            switchView?.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

            accessoryType = .none
            
            settingsName.trailingAnchor.constraint(greaterThanOrEqualTo: switchView!.leadingAnchor, constant: 10).isActive = true
        } else {
            settingsName.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 10).isActive = true
        }
    }
}
