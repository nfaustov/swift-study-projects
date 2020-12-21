//
//  ExtImageView.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 18.12.2020.
//

import UIKit

extension UIImageView {
     func load(url: URL) {
         DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                 if let image = UIImage(data: data) {
                     DispatchQueue.main.async {
                         self?.image = image
                     }
                 }
             }
         }
     }
 }
