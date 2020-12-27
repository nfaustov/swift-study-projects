//
//  ForecastTableViewCell.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 18.12.2020.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {
    
    private let dateFormatter: DateFormatter = {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ru_RU")
        format.dateFormat = "EEEE"
        return format
    }()

    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dayTemperatureLabel: UILabel!
    @IBOutlet weak var nightTemperatureLabel: UILabel!
    
    func configure(_ forecast: DailyForecast) {
        weekDayLabel.text = dateFormatter.string(from: forecast.dt)
        dayTemperatureLabel.text = "\(Int(forecast.temp.day))°C"
        nightTemperatureLabel.text = "\(Int(forecast.temp.night))°C"
        
        guard let weather = forecast.weather.first,
              let iconURL = URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png") else { return }
        weatherImageView.load(url: iconURL)
    }
}
