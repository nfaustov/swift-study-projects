//
//  CellModel.swift
//  StudyProject10
//
//  Created by Nikolai Faustov on 08.06.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import Foundation
import UIKit

struct Cell {
    let color: UIColor
    let imageName: String
    let name: String
    let textStatus: String?
    let imageStatusName: String?
    let switchOption: Bool
    
    init(color: UIColor, imageName: String, name: String, textStatus: String? = nil, imageStatusName: String? = nil, switchOption: Bool = false) {
        self.color = color
        self.imageName = imageName
        self.name = name
        self.textStatus = textStatus
        self.imageStatusName = imageStatusName
        self.switchOption = switchOption
    }
}
