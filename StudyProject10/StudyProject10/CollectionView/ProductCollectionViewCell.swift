//
//  ProductCollectionViewCell.swift
//  StudyProject10
//
//  Created by Nikolai Faustov on 13.06.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var oldPriceLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var discountLabel: UILabel!
    
    func configureView(from model: ProductModel) {
        
        productImageView.image = UIImage(named: model.imageName)
        
        oldPriceLabel.text = "\(model.oldPrice) руб."
        
        priceLabel.text = "\(model.price) руб."
        
        productNameLabel.text = model.productName
        
        discountLabel.text = "-\(model.discount)%"
    }
}
