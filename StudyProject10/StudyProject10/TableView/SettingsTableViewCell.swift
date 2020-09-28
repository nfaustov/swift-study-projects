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
    
    @IBOutlet weak var textStatusLabel: UILabel!
    
    @IBOutlet weak var imageStatusView: UIImageView!
    
    @IBOutlet weak var switchView: UISwitch!
    
    func configureView(fromModel cellModel: Cell) {
        
        accessoryType = .disclosureIndicator
        separatorInset.left = settingsName.frame.origin.x
        
        settingsImage.image = UIImage(systemName: cellModel.imageName)
        settingsImage.layer.cornerRadius = 6
        settingsImage.contentMode = .center
        settingsImage.tintColor = .white
        settingsImage.backgroundColor = cellModel.color
        
        settingsName.text = cellModel.name
        
        if cellModel.textStatus != nil  {
            textStatusLabel.isHidden = false
            textStatusLabel?.text = cellModel.textStatus
            textStatusLabel?.textColor = .systemGray
        } else {
            textStatusLabel.isHidden = true
        }
        
        if cellModel.imageStatusName != nil {
            imageStatusView.isHidden = false
            imageStatusView.image = UIImage(systemName: cellModel.imageStatusName!)
            imageStatusView?.tintColor = .systemRed
        } else {
            imageStatusView.isHidden = true
        }
        
        if cellModel.switchOption {
            switchView?.isOn = false
            switchView.isHidden = false

            accessoryType = .none
        } else {
            switchView.isHidden = true
        }
    }
}
