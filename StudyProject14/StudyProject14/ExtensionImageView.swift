//
//  ExtensionImageView.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 16.03.2021.
//

import UIKit

extension UIImageView {
    func load(url: URL, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion(image)
                     } 
                 }
             }
         }
     }
 }
