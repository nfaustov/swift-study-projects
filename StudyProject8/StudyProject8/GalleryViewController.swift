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
    
    let images: [UIImage?] = [
        UIImage(named: "1"), UIImage(named: "2"),
        UIImage(named: "3"), UIImage(named: "4"),
        UIImage(named: "5"), UIImage(named: "6"),
        UIImage(named: "7"), UIImage(named: "8"),
        UIImage(named: "9"), UIImage(named: "10")
        ]

    lazy var animationImages: [UIImage] = images.compactMap { $0 }
    
    var timer: Timer?
    
    var count = 0 {
       didSet { stepper.value = Double(count) }
        // отслеживаем count, чтобы stepper пееключал с той картинки, на которой остановилась анимация
    }
    
    var currentProgress: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageContainer.image = images[0]
        
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
        count = Int(stepper.value)
        // это нужно, чтобы newImages() изменил массив картинок и запустил анимацию с того места, где остановился stepper
        // count также выступает в роли индекса в цикле в updateProgress()
        updateProgress()
        // используя stepper также меняем состояние progressView
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
            // меняем последовательность картинок в анимации, чтобы начать ее с той картинки, которая показывается в текущий момент
            // если count не менялся до этого, т.е. 0, то используем стартовую последовательность
            // возможно эта проверка лишняя, если count равен 0, то последовательность все равно не изменится, просто лишний раз выполнится цикл
            count = 0
        }
        
        imageContainer.animationImages = animationImages
        imageContainer.animationDuration = 6.0
        imageContainer.startAnimating()
        
        let timeInterval = imageContainer.animationDuration / Double(images.count)
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
        // берем интервал смены картинки в анимации и в nextImage() устанавливаем счетчик (count) и изменение progressView
        timer?.tolerance = 0.1 * timeInterval
        // возможно это тоже лишнее в текущей задаче, но такие рекомендации по допуску дает apple
    }
    
    @IBAction func stopButton() {
        
        timer?.invalidate()
        
        imageContainer.stopAnimating()
        imageContainer.image = animationImages[count]
    }
    
    @objc func nextImage() {
        
        count += 1
        if count == animationImages.count {
            count = 0
        }
        
        updateProgress()
    }
    
    func newImages(_ oldImages: inout [UIImage]) {
        // перемещаем все картинки c индекса count в начало массива сохраняя их последовательность
        for index in count..<oldImages.count {
            let image = oldImages.remove(at: index)
            oldImages.insert(image, at: index - count)
        }
    }
    
    func updateProgress() {
        
        let progressStepValue = 1 / Float(animationImages.count - 1)
        for image in images {
            if animationImages[count] == image {
                if let value = images.firstIndex(of: image) {
                    currentProgress = progressStepValue * Float(value)
                    }
                // поскольку count обнуляется при каждом запуске анимации и массив изменяется,
                // то для корректного отображения progressView находим индекс текущей картинки в первоначальном массиве
            }
        }
        
        animationProgressView.setProgress(currentProgress, animated: false)
    }
}

