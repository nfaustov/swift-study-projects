//
//  ViewController.swift
//  StudyProject13
//
//  Created by Nikolai Faustov on 19.01.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var redBox: UIView!
    
    private var animationNumber = 0 {
        didSet {
            descriptionLabel.text = "\(animationNumber)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationNumber = 1
        
        redBox = UIView()
        redBox.backgroundColor = .systemRed
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        redBox.addGestureRecognizer(tapGesture)
        view.addSubview(redBox)
        
        redBox.translatesAutoresizingMaskIntoConstraints = false 
        NSLayoutConstraint.activate([
            redBox.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            redBox.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            redBox.widthAnchor.constraint(equalToConstant: 150),
            redBox.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    @IBAction func previousAnimation() {
        animationNumber = max(1, animationNumber - 1)
    }
    
    @IBAction func nextAnimation() {
        animationNumber = min(7, animationNumber + 1)
    }
    
    @objc func handleTapGesture(_ recognizer: UITapGestureRecognizer) {
        let options: UIView.AnimationOptions = animationNumber == 7 ? [.repeat] : []
        redBox.animate(animations(), options: options)
    }

    private func animations() -> [Animation] {
        switch animationNumber {
        case 1: return [.paintYellow(duration: 1), .paintRed(duration: 1)]
        case 2: return [.translation(duration: 1), .identityTransform(duration: 1)]
        case 3: return [.makeItRound(duration: 1), .makeItSquare(duration: 1)]
        case 4: return [.rotate(duration: 1), .identityTransform(duration: 1)]
        case 5: return [.fadeOut(duration: 1), .fadeIn(duration: 1)]
        case 6: return [.scaleUp(duration: 1), .identityTransform(duration: 1)]
        case 7: return [.rotate(duration: 2)]
        default: return []
        }
    }
}

