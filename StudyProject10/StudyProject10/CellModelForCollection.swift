//
//  CellModelForCollection.swift
//  StudyProject10
//
//  Created by Nikolai Faustov on 15.06.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import Foundation

struct ProductModel {
    let imageName: String
    let productName: String
    let oldPrice: Int
    let discount: Int
    let price: Double
    
    init(imageName: String, productName: String, oldPrice: Int, discount: Int) {
        self.imageName = imageName
        self.productName = productName
        self.oldPrice = oldPrice
        self.discount = discount
        self.price = Double(oldPrice) * Double(100 - discount) / Double(100)
    }
}
