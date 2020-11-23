//
//  SecureTextField.swift
//  StudyProject11
//
//  Created by Nikolai Faustov on 14.09.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

@IBDesignable
class SecureTextField: UIView {

    private let textField = UITextField()
    private let placeholderLabel = UILabel()
    private let progressView = UIProgressView()
    private let statusLabel = UILabel()
    
    private let textFieldOverlayButton = UIButton(type: .custom)
    
    private let secureImage = UIImage(systemName: "eye.slash")
    private let insecureImage = UIImage(systemName: "eye")
    
    private var scale: CGFloat {
        return escapedPlaceholderSize / placeholderFontSize
    }
    
    private var numberOfCharacters: Int {
        return textField.text?.count ?? 0
    }

    var statusText = "At least 6 characters"
    
    var escapedPlaceholderSize: CGFloat = 14
    var placeholderFontSize: CGFloat = 17

    var isEmpty: Bool {
        return textField.text?.isEmpty ?? true
    }

    private func setupTextField() {
        textFieldOverlayButton.setImage(secureImage, for: .normal)
        textFieldOverlayButton.addTarget(self, action: #selector(isSecureText), for: .touchUpInside)
        textFieldOverlayButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        textFieldOverlayButton.tintColor = .lightGray
        textFieldOverlayButton.adjustsImageWhenHighlighted = false

        textField.borderStyle = .none
        textField.frame = CGRect(x: 0, y: escapedPlaceholderSize, width: bounds.width, height: placeholderFontSize)
        textField.autoresizingMask = [.flexibleWidth]
        textField.isSecureTextEntry = true
        textField.rightView = textFieldOverlayButton
        textField.rightViewMode = .always
        addSubview(textField)
        textField.addTarget(self, action: #selector(textRecognizer), for: .allEditingEvents)
    }

    private func setupPlaceholderLabel() {
        placeholderLabel.text = "Password"
        placeholderLabel.textColor = .lightGray
        placeholderLabel.font = UIFont.systemFont(ofSize: placeholderFontSize)
        placeholderLabel.frame = textField.bounds
        textField.addSubview(placeholderLabel)
    }

    @objc func isSecureText() {
        textField.isSecureTextEntry.toggle()
        textFieldOverlayButton.setImage(textField.isSecureTextEntry ? secureImage : insecureImage, for: .normal)
    }

    @objc func textRecognizer() {
        let isActive = textField.isFirstResponder || !isEmpty
        statusLabel.isHidden = !textField.isFirstResponder

        let offsetX = -placeholderLabel.bounds.width * (1 - scale) / 2
        let offsetY = -placeholderLabel.bounds.height * (1 - scale) / 2

        let transform = CGAffineTransform(translationX: offsetX, y: offsetY - placeholderFontSize - 3).scaledBy(x: scale, y: scale)

        var color: UIColor = .clear
        
        if numberOfCharacters >= 10 {
            color = .systemGreen
            statusText = "Secure password"
        } else if numberOfCharacters >= 6 {
            color = .systemOrange
            statusText = "Add more characters to be more secure"
        } else if numberOfCharacters > 0 {
            color = .systemRed
            statusText = "Unsafe password"
        } else {
            color = .lightGray
            statusText = "At least 6 characters"
        }

        UIView.animate(withDuration: 0.25) {
            self.placeholderLabel.transform = isActive ? transform : .identity
            self.progressView.progress = Float(self.numberOfCharacters) / 10
            self.statusLabel.text = self.statusText
            self.statusLabel.textColor = color
            self.progressView.tintColor = color
        }
    }

    private func setupProgressView() {
        progressView.frame = CGRect(x: 0, y: textField.frame.maxY + 1, width: textField.frame.width, height: 1)
        progressView.autoresizingMask = [.flexibleWidth]

        addSubview(progressView)
    }

    private func setupStatusLabel() {
        statusLabel.textColor = .lightGray
        statusLabel.font = UIFont.systemFont(ofSize: escapedPlaceholderSize - 1)
        statusLabel.frame.size = CGSize(width: textField.frame.width, height: escapedPlaceholderSize)
        
        statusLabel.frame.origin = CGPoint(x: 0, y: progressView.frame.maxY + 2)
        statusLabel.isHidden = true
        addSubview(statusLabel)
    }

    private func commonInit() {
        textField.delegate = self
        
        setupTextField()
        setupPlaceholderLabel()
        setupProgressView()
        setupStatusLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        commonInit()
    }
}

extension SecureTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        progressView.tintColor = .systemGray5
    }
}

