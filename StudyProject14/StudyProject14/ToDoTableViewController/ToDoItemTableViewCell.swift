//
//  ToDoItemTableViewCell.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 08.03.2021.
//

import UIKit

final class ToDoItemTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ToDoItemTableViewCell"
    
    let titleLabel = UILabel()
    
    func configure(_ item: ModelType) {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        titleLabel.text = item.title
    }

}
