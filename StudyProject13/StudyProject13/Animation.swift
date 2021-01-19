//
//  Animation.swift
//  StudyProject13
//
//  Created by Nikolai Faustov on 19.01.2021.
//

import UIKit

struct Animation {
    var duration: TimeInterval
    var handler: (UIView) -> Void
}

extension Animation {
    static func fadeOut(duration: TimeInterval) -> Animation {
        return Animation(duration: duration, handler: { $0.alpha = 0 })
    }
    
    static func fadeIn(duration: TimeInterval) -> Animation {
        return Animation(duration: duration, handler: { $0.alpha = 1 })
    }
    
    static func paintYellow(duration: TimeInterval) -> Animation {
        return Animation(duration: duration, handler: { $0.backgroundColor = .systemYellow })
    }
    
    static func paintRed(duration: TimeInterval) -> Animation {
        return Animation(duration: duration, handler: { $0.backgroundColor = .systemRed })
    }
    
    static func translation(duration: TimeInterval) -> Animation {
        return Animation(duration: duration, handler: { $0.transform = .init(translationX: 100, y: -100) })
    }
    
    static func rotate(duration: TimeInterval) -> Animation {
        return Animation(duration: duration, handler: { $0.transform = .init(rotationAngle: CGFloat.pi) })
    }
    
    static func scaleUp(duration: TimeInterval) -> Animation {
        return Animation(duration: duration, handler: { $0.transform = .init(scaleX: 2, y: 2) })
    }
    
    static func identityTransform(duration: TimeInterval) -> Animation {
        return Animation(duration: duration, handler: { $0.transform =  .identity })
    }
    
    static func makeItRound(duration: TimeInterval) -> Animation {
        return Animation(duration: duration, handler: { $0.layer.cornerRadius = 75 })
    }
    
    static func makeItSquare(duration: TimeInterval) -> Animation {
        return Animation(duration: duration, handler: { $0.layer.cornerRadius = 0 })
    }
}

extension UIView {
    func animate(_ animations: [Animation], options: UIView.AnimationOptions) {
        guard !animations.isEmpty else { return }
        
        var animations = animations
        let animation = animations.removeFirst()
        
        UIView.animate(withDuration: animation.duration, delay: 0, options: options) {
            animation.handler(self)
        } completion: { _ in
            self.animate(animations, options: options)
        }
    }
}
