//
//  ForecastTableViewCell.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 27.11.2020.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    let dateFormatter = DateFormatter()

    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dayTemperatureLabel: UILabel!
    @IBOutlet weak var nightTemperatureLabel: UILabel!
    
    func configure(_ forecast: Forecast) {
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "EEEE"
        weekDayLabel.text = dateFormatter.string(from: forecast.date)
        weatherImageView.load(url: forecast.imageURL)
        dayTemperatureLabel.text = "\(Int(forecast.dayTemperature))°C"
        nightTemperatureLabel.text = "\(Int(forecast.nightTemperature))°C"
    }
}
