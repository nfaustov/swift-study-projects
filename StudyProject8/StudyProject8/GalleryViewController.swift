//
//  GalleryViewController.swift
//  StudyProject8
//
//  Created by Nikolai Faustov on 20.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var imageContainer: UIImageView!
    
    @IBOutlet weak var imageRemoteView: UIView!
    @IBOutlet weak var animationRemoteView: UIView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var animationProgressView: UIProgressView!
    
    @IBOutlet weak var alphaSwitch: UISwitch!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let images: [UIImage] = [
        UIImage(named: "1"), UIImage(named: "2"),
        UIImage(named: "3"), UIImage(named: "4"),
        UIImage(named: "5"), UIImage(named: "6"),
        UIImage(named: "7"), UIImage(named: "8"),
        UIImage(named: "9"), UIImage(named: "10")
        ].compactMap { $0 }

    lazy var animationImages: [UIImage] = images
    
    var timer: Timer?
    
    var count: Double = 0 {
        
       didSet { stepper.value = count }
    }
    
    var currentProgress: Float = 0
    
    var displayLink: CADisplayLink?
    var startTime: CFTimeInterval?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageContainer.image = images.first
        
        stepper.minimumValue = 0
        stepper.maximumValue = Double(images.count - 1)
        stepper.stepValue = 1
        stepper.wraps = true
        stepper.setIncrementImage(UIImage(named: "next")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        stepper.setDecrementImage(UIImage(named: "back")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        
        slider.minimumTrackTintColor = UIColor.systemYellow
        slider.maximumTrackTintColor = UIColor.systemGray3
        slider.thumbTintColor = UIColor.orange
        slider.value = 0
        slider.minimumValue = 0
        slider.maximumValue = 1
        
        animationProgressView.progress = 0
        animationProgressView.progressTintColor = UIColor.systemRed
        animationProgressView.trackTintColor = UIColor.label
        
        alphaSwitch.isOn = false
        alphaSwitch.onTintColor = UIColor.systemGray2
        alphaSwitch.thumbTintColor = UIColor.orange
        alphaSwitch.addTarget(self, action: #selector(switchRemote), for: .valueChanged)
        
        activityIndicator.hidesWhenStopped = true
    }
    
    @IBAction func stepped() {
        
        imageContainer.image = animationImages[Int(stepper.value)]
        count = stepper.value
        updateProgress()
    }
    
    @IBAction func slide() {
        
        imageContainer.frame.origin.x = CGFloat(slider.value) * imageContainer.frame.width
    }
    
    @objc func switchRemote() {
        
        if alphaSwitch.isOn {
            imageContainer.alpha = 0.3
            activityIndicator.startAnimating()
        }
        else {
            imageContainer.alpha = 1
            activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func startButton() {
        
        if count != 0 {
            newImages(&animationImages)
            count = 0
        }
        
        imageContainer.animationImages = animationImages
        imageContainer.animationDuration = 6.0
        imageContainer.startAnimating()

        startTime = CACurrentMediaTime()
        displayLink = CADisplayLink(target: self, selector: #selector(nextImage))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    @IBAction func stopButton() {
        
        displayLink?.isPaused = true
        displayLink?.invalidate()
        
        imageContainer.stopAnimating()
        imageContainer.image = animationImages[Int(count)]
    }
    
    @objc func nextImage() {
        
        let now = CACurrentMediaTime()
        guard let startTime = startTime else {return}
        let timeInterval = imageContainer.animationDuration / Double(animationImages.count)
        count = (now - startTime) / timeInterval
        
        if count >= Double(animationImages.count) {
            count = 0
        }

        updateProgress()
    }
    
    func newImages(_ oldImages: inout [UIImage]) {
        
        for index in Int(count)..<oldImages.count {
            let image = oldImages.remove(at: index)
            oldImages.insert(image, at: index - Int(count))
        }
    }
    
    func updateProgress() {
        
        let progressStepValue = 1 / Float(animationImages.count - 1)
        for image in images {
            if animationImages[Int(count)] == image {
                if let value = images.firstIndex(of: image) {
                    currentProgress = progressStepValue * Float(value)
                }
            }
        }
        
        animationProgressView.setProgress(currentProgress, animated: false)
    }
}

