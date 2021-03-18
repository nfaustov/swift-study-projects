//
//  NameViewController.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 08.03.2021.
//

import UIKit

final class NameViewController: UIViewController {
    private var user = User()
    
    private let firstNameTextField = UITextField()
    private let secondNameTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let firstNameLabel = UILabel()
        firstNameLabel.text = "Имя: "
        
        let secondNameLabel = UILabel()
        secondNameLabel.text = "Фамилия: "
        
        firstNameTextField.borderStyle = .roundedRect
        firstNameTextField.delegate = self
        secondNameTextField.borderStyle = .roundedRect
        secondNameTextField.delegate = self
        
        
        view.addSubview(firstNameLabel)
        view.addSubview(secondNameLabel)
        view.addSubview(firstNameTextField)
        view.addSubview(secondNameTextField)
        
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        secondNameLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        secondNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            firstNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            secondNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            secondNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 20),
            
            firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.topAnchor),
            firstNameTextField.leadingAnchor.constraint(equalTo: secondNameTextField.leadingAnchor),
            firstNameTextField.widthAnchor.constraint(equalTo: secondNameTextField.widthAnchor),
            firstNameTextField.heightAnchor.constraint(equalTo: firstNameLabel.heightAnchor),
            
            secondNameTextField.topAnchor.constraint(equalTo: secondNameLabel.topAnchor),
            secondNameTextField.leadingAnchor.constraint(equalTo: secondNameLabel.trailingAnchor, constant: 20),
            secondNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -secondNameLabel.frame.width - 200),
            secondNameTextField.heightAnchor.constraint(equalTo: secondNameLabel.heightAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        firstNameTextField.text = user.firstName
        secondNameTextField.text = user.secondName
    }
}

extension NameViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        user.firstName = firstNameTextField.text ?? ""
        user.secondName = secondNameTextField.text ?? ""
    }
}
