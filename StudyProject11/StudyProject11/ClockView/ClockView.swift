//
//  ClockView.swift
//  StudyProject11
//
//  Created by Nikolai Faustov on 20.07.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

@IBDesignable
class ClockView: UIView {
    
    private var hourPoints = 12
    
    @IBInspectable var classicView: Bool = true {
        didSet {
            hourPoints = classicView ? 12 : 24
            layoutIfNeeded()
        }
    }
    
    private let calendar = Calendar.current
    
    private var date = Date() {
        didSet {
            currentSecond = CGFloat(calendar.component(.second, from: date))
            currentMinute = CGFloat(calendar.component(.minute, from: date)) + currentSecond / 60
            currentHour = CGFloat(calendar.component(.hour, from: date)) + currentMinute / 60
        }
    }
    
    private var displayLink: CADisplayLink?

    private var currentSecond: CGFloat = 0
    private var currentMinute: CGFloat = 0
    private var currentHour: CGFloat = 0
    
    @IBInspectable var hourClockHandLength: CGFloat = 80 { didSet { layoutIfNeeded() } }
    @IBInspectable var hourClockHandWidth: CGFloat = 4 { didSet { layoutIfNeeded() } }
    @IBInspectable var hourClockHandColor: UIColor = .black { didSet { layoutIfNeeded() } }
    
    @IBInspectable var minuteClockHandLength: CGFloat = 110 { didSet { layoutIfNeeded() } }
    @IBInspectable var minuteClockHandWidth: CGFloat = 2 { didSet { layoutIfNeeded() } }
    @IBInspectable var minuteClockHandColor: UIColor = .black { didSet { layoutIfNeeded() } }
    
    @IBInspectable var secondClockHandLength: CGFloat = 140 { didSet { layoutIfNeeded() } }
    @IBInspectable var secondClockHandWidth: CGFloat = 1 { didSet { layoutIfNeeded() } }
    @IBInspectable var secondClockHandColor: UIColor = .black { didSet { layoutIfNeeded() } }
    
    private var angle = CGFloat(3 * CGFloat.pi / 2)
    
    private var clockHands = [UIView]()
    
    enum TimeValue: String {
        case hour, minute, second
    }
    
    private func angleIncrement(by timeValue: TimeValue) -> CGFloat {
        switch timeValue {
        case .hour: return CGFloat(Double.pi * 2 / Double(hourPoints))
        default: return CGFloat(Double.pi * 2 / Double(60))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    deinit {
        displayLink?.invalidate()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        initialize()
    }
    
    func initialize() {
        layer.cornerRadius = frame.size.width / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray.cgColor

        let clockCenter = CGPoint(x: bounds.origin.x + bounds.width / 2, y: bounds.origin.y + bounds.height / 2)

        addHourPoints(center: clockCenter)
        addMinutePoints(center: clockCenter)

        createClockHand(at: clockCenter, for: .hour)
        createClockHand(at: clockCenter, for: .minute)
        createClockHand(at: clockCenter, for: .second)
    }
    
    func activate(state: Bool) {
        if state {
            displayLink = CADisplayLink(target: self, selector: #selector(currentTime))
            displayLink?.add(to: .current, forMode: .default)
        } else {
            displayLink?.invalidate()
        }
    }
    
    @objc func currentTime() {
        date = Date()

        for clockHand in clockHands {
            let timeValue = TimeValue(rawValue: clockHand.restorationIdentifier ?? "")
            clockHand.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
            switch timeValue {
            case .hour:
                let rotationAngle = angle + angleIncrement(by: .hour) * currentHour
                UIView.animate(withDuration: 0.1) {
                    clockHand.transform = CGAffineTransform(rotationAngle: rotationAngle)
                }
            case .minute:
                let rotationAngle = angle + angleIncrement(by: .minute) * currentMinute
                UIView.animate(withDuration: 0.1) {
                    clockHand.transform = CGAffineTransform(rotationAngle: rotationAngle)
                }
            default:
                let rotationAngle = angle + angleIncrement(by: .second) * currentSecond
                UIView.animate(withDuration: 0.1) {
                    clockHand.transform = CGAffineTransform(rotationAngle: rotationAngle)
                }
            }
        }
    }
    
    private func addHourPoints(center: CGPoint) {
        let radius: CGFloat = bounds.width / 2 - 15
        
        for hourPoint in 1...hourPoints {
            angle += angleIncrement(by: .hour)
            let point = clockPointFrom(angle: angle, radius: radius, offset: center)
            if hourPoint % 3 != 0 {
                createHourView(at: point, rotationAngle: angle)
            } else {
                createHourLabel(at: point, text: "\(hourPoint)")
            }
        }
    }
    
    private func addMinutePoints(center: CGPoint) {
        let radius: CGFloat = bounds.width / 2 - 40
        
        for minutePoint in 1...60 {
            angle += angleIncrement(by: .minute)
            if minutePoint % 5 == 0, !classicView {
                let point = clockPointFrom(angle: angle, radius: radius, offset: center)
                createMinuteLabel(at: point, text: "\(minutePoint)")
            } else if minutePoint % 5 != 0, classicView {
                let point = clockPointFrom(angle: angle, radius: radius + 25, offset: center)
                createMinuteView(at: point, rotationAngle: angle)
            }
        }
    }
    
    private func createClockHand(at center: CGPoint, for value: TimeValue) {
        let clockHand: ClockHand
        let clockHandColor: UIColor
        
        switch value {
        case .hour:
            clockHand = ClockHand(length: hourClockHandLength, width: hourClockHandWidth, timePoint: currentHour)
            clockHandColor = hourClockHandColor
        case .minute:
            clockHand = ClockHand(length: minuteClockHandLength, width: minuteClockHandWidth, timePoint: currentMinute)
            clockHandColor = minuteClockHandColor
        case .second:
            clockHand = ClockHand(length: secondClockHandLength, width: secondClockHandWidth, timePoint: currentSecond)
            clockHandColor = secondClockHandColor
        }
        
        let origin = CGPoint(x: center.x, y: center.y - clockHand.width / 2)
        let rotationAngle = angle + angleIncrement(by: value) * clockHand.timePoint
        
        let clockHandView = UIView()
        clockHandView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        clockHandView.frame = CGRect(origin: origin, size: CGSize(width: clockHand.length, height: clockHand.width))
        clockHandView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        clockHandView.backgroundColor = clockHandColor
        clockHandView.layer.cornerRadius = 6
        clockHandView.restorationIdentifier = value.rawValue
        addSubview(clockHandView)
        clockHands.append(clockHandView)
    }
    
    private func createHourView(at point: CGPoint, rotationAngle: CGFloat) {
        let hView = UIView()
        hView.frame.size = CGSize(width: 10, height: 2)
        hView.backgroundColor = .systemGray
        hView.center = point
        hView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        addSubview(hView)
    }
    
    private func createHourLabel(at point: CGPoint, text: String) {
        let label = UILabel()
        label.text = text
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.center = point
        addSubview(label)
    }
    
    private func createMinuteView(at point: CGPoint, rotationAngle: CGFloat) {
        let mView = UIView()
        mView.frame.size = CGSize(width: 6, height: 1)
        mView.backgroundColor = .systemGray3
        mView.center = point
        mView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        addSubview(mView)
    }
    
    private func createMinuteLabel(at point: CGPoint, text: String) {
        let label = UILabel()
        label.text = text
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.textColor = .systemGray3
        label.center = point
        addSubview(label)
    }
    
    private func clockPointFrom(angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
        let x = radius * cos(angle) + offset.x
        let y = radius * sin(angle) + offset.y
        
        return CGPoint(x: x, y: y)
    }
}

