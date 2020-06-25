//
//  CellModelForCollection.swift
//  StudyProject10
//
//  Created by Nikolai Faustov on 15.06.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import Foundation

struct ProductModel {
    var imageName: String
    var productName: String
    var price: Int
    var oldPrice: Int
    var discount: Int {
        return Int(Double(oldPrice - price) / Double(oldPrice) * 100)
    }
}
