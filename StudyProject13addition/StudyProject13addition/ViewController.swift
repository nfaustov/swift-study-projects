//
//  ViewController.swift
//  StudyProject13addition
//
//  Created by Nikolai Faustov on 03.02.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    private enum GreenViewState: Int {
        case expanded = -1
        case collapsed = 1
        
        var change: GreenViewState {
            switch self {
            case .collapsed: return .expanded
            case .expanded: return .collapsed
            }
        }
    }
    
    private var greenViewState: GreenViewState = .expanded
    
    private var stateFrame: CGRect {
        switch greenViewState {
        case .expanded: return CGRect(x: 0, y: 200, width: view.frame.width, height: view.frame.height - 200)
        case .collapsed: return CGRect(x: 0, y: view.frame.height - 200, width: view.frame.width, height: 200)
        }
    }
    
    private let topicsNumber = 6
    
    private var greenView: UIView!
    private var topicViews = [TopicView]()

    private var greenViewAmplitude: CGFloat {
        view.bounds.height - 400
    }
    
    private lazy var greenViewAnimator = UIViewPropertyAnimator(duration: 0.8, curve: .easeInOut)
    private lazy var topicAnimator = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        greenView = UIView(frame: stateFrame)
        greenView.backgroundColor = .systemGreen
        
        addTopics()
        view.addSubview(greenView)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        greenView.addGestureRecognizer(pan)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translationY = gesture.translation(in: view).y
        switch gesture.state {
        case .began:
            greenViewState = greenViewState.change
            greenViewAnimator.addAnimations {
                self.greenView.frame = self.stateFrame
                self.topicsAppearence()
            }
            greenViewAnimator.startAnimation()
            greenViewAnimator.pauseAnimation()
        case .changed:
            greenViewAnimator.fractionComplete = translationY / greenViewAmplitude * CGFloat(greenViewState.rawValue)
        case .ended:
            if greenViewAnimator.fractionComplete < 0.35 {
                greenViewState = greenViewState.change
                greenViewAnimator.isReversed = true
            }
            greenViewAnimator.continueAnimation(
                withTimingParameters: nil,
                durationFactor: 1 - greenViewAnimator.fractionComplete
            )
        default: break
        }
    }
    
    @objc private func handleTopicPan(_ gesture: UIPanGestureRecognizer) {
        guard let topicView = gesture.view as? TopicView,
              let index = topicViews.firstIndex(of: topicView) else { return }

        let translationX = gesture.translation(in: view).x

        let velocity = gesture.velocity(in: view)
        let velocityFactor = abs(velocity.x) / 150

        let newTopic = TopicView(
            frame: CGRect(
                x: view.frame.width,
                y: 150 + CGFloat(65 * (index + 1)),
                width: view.frame.width - 80,
                height: 50
            )
        )

        view.insertSubview(newTopic, belowSubview: greenView)

        switch gesture.state {
        case .began:
            topicAnimator.addAnimations {
                topicView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                topicView.alpha = 0
            }
            topicAnimator.startAnimation()
            topicAnimator.pauseAnimation()
        case .changed:
            topicAnimator.fractionComplete = -translationX / topicView.bounds.width
        case .ended:
            if topicAnimator.fractionComplete < 0.2 {
                topicAnimator.isReversed = true
            } else {
                topicAnimator.addCompletion { _ in
                    topicView.removeFromSuperview()
                    self.topicViews.insert(newTopic, at: index)
                    self.topicViews.remove(at: index)
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: min(0.8 / Double(velocityFactor), 1), delay: 0) {
                        newTopic.frame.origin.x = 40
                    }
                }
            }
            topicAnimator.continueAnimation(
                withTimingParameters: nil,
                durationFactor: (1 - topicAnimator.fractionComplete)
            )
        default: break
        }
    }
    
    private func addTopics() {
        for number in 1...topicsNumber {
            let topicView = TopicView()
            topicView.frame = CGRect(x: 40, y: 150 + CGFloat(65 * number), width: view.frame.width - 80, height: 50)
            view.addSubview(topicView)
            topicView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            topicViews.append(topicView)
            let topicPan = UIPanGestureRecognizer(target: self, action: #selector(handleTopicPan(_:)))
            topicView.addGestureRecognizer(topicPan)
        }
    }

    private func topicsAppearence() {
        topicViews.forEach { topicView in
            switch self.greenViewState {
            case .expanded:
                topicView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                topicView.alpha = 0
            case .collapsed:
                topicView.transform = .identity
                topicView.alpha = 1
            }
        }
    }
}
