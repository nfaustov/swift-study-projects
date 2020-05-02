//
//  DateViewController.swift
//  StudyProject8
//
//  Created by Nikolai Faustov on 01.05.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var timeZoneTextField: UITextField!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.backgroundColor = UIColor.white
        datePicker.layer.shadowOpacity = 0.6
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        
        timeZoneTextField.addTarget(self, action: #selector(changeTimeZone), for: .editingChanged)
    }
    
    @objc func changeDate() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM EEEE H:mm"
        currentTimeLabel.text = formatter.string(from: datePicker.date)
    }
    
    @objc func changeTimeZone() {

        let calendar = Calendar.current

        guard let timeZone = Int(timeZoneTextField.text ?? "") else { return }
        guard let newDate = calendar.date(byAdding: .hour, value: timeZone - 3, to: datePicker.date) else { return }
        // (timeZone - 3) потому что текущее +3
        datePicker.setDate(newDate, animated: true)
        changeDate()
    }
}
