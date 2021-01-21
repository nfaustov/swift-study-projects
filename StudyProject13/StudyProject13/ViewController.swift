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
    
    var animator: UIViewPropertyAnimator!
    
    let reversedAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear)
    let repeatAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear)
    
    var rotationAngle = CGFloat.zero
    
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

        view.addSubview(redBox)
        
        redBox.translatesAutoresizingMaskIntoConstraints = false 
        NSLayoutConstraint.activate([
            redBox.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            redBox.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            redBox.widthAnchor.constraint(equalToConstant: 150),
            redBox.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        launchAnimation()
    }

    @IBAction func previousAnimation() {
        if animator.state == .active {
            animator.stopAnimation(false)
        }
        if animator.state == .stopped {
            animator.finishAnimation(at: .start)
        }
        animationNumber = max(1, animationNumber - 1)
        launchAnimation()
    }
    
    @IBAction func nextAnimation() {
        if animator.state == .active {
            animator.stopAnimation(false)
        }
        if animator.state == .stopped {
            animator.finishAnimation(at: .start)
        }
        animationNumber = min(7, animationNumber + 1)
        launchAnimation()
    }
    
    private func launchAnimation() {
        //let options: UIView.AnimationOptions = animationNumber == 7 ? [.repeat] : []
        //redBox.animate(animations(), options: options)
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear)
        animator.addAnimations {
            self.animation()
        }
        
        animator.addCompletion { _ in
            if self.animationNumber == 7 {
                self.rotationAngle += CGFloat.pi
                self.launchAnimation()
            } else {
                self.reversedAnimator.addAnimations(self.reversedAnimation)
                self.reversedAnimator.startAnimation()
            }
        }
        
        animator.startAnimation()
    }
    
    private func animation() {
        switch animationNumber{
        case 1: redBox.backgroundColor = .systemYellow
        case 2: redBox.transform = .init(translationX: 100, y: -100)
        case 3: redBox.layer.cornerRadius = 75
        case 4: redBox.transform = .init(rotationAngle: CGFloat.pi)
        case 5: redBox.alpha = 0
        case 6: redBox.transform = .init(scaleX: 2, y: 2)
        case 7: redBox.transform = .init(rotationAngle: rotationAngle)
        default: break
        }
    }
    
    private func reversedAnimation() {
        switch animationNumber{
        case 1: redBox.backgroundColor = .systemRed
        case 2: redBox.transform = .identity
        case 3: redBox.layer.cornerRadius = 0
        case 4: redBox.transform = .identity
        case 5: redBox.alpha = 1
        case 6: redBox.transform = .identity
        default: break
        }
    }

//    private func animations() -> [Animation] {
//        switch animationNumber {
//        case 1: return [.paintYellow(duration: 1), .paintRed(duration: 1)]
//        case 2: return [.translation(duration: 1), .identityTransform(duration: 1)]
//        case 3: return [.makeItRound(duration: 1), .makeItSquare(duration: 1)]
//        case 4: return [.rotate(duration: 1), .identityTransform(duration: 1)]
//        case 5: return [.fadeOut(duration: 1), .fadeIn(duration: 1)]
//        case 6: return [.scaleUp(duration: 1), .identityTransform(duration: 1)]
//        case 7: return [.rotate(duration: 2)]
//        default: return []
//        }
//    }
}

