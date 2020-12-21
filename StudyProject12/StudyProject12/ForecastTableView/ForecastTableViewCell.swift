//
//  ForecastTableViewCell.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 18.12.2020.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    let dateFormatter = DateFormatter()

    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dayTemperatureLabel: UILabel!
    @IBOutlet weak var nightTemperatureLabel: UILabel!
    
    func configure(_ forecast: DailyForecast) {
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "EEEE"
        weekDayLabel.text = dateFormatter.string(from: forecast.dt)
        
        guard let weather = forecast.weather.first else { return }
        guard let iconURL = URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png") else { return }
        weatherImageView.load(url: iconURL)
        dayTemperatureLabel.text = "\(Int(forecast.temp.day))°C"
        nightTemperatureLabel.text = "\(Int(forecast.temp.night))°C"
    }
}
