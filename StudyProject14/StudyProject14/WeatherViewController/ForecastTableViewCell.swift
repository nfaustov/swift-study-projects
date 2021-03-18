//
//  ForecastTableViewCell.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 16.03.2021.
//

import UIKit
import RealmSwift

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
        guard let temperature = forecast.temp,
              let weather = forecast.weather.first,
              let iconURL = URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png") else { return }
        
        weekDayLabel.text = dateFormatter.string(from: forecast.dt)
        dayTemperatureLabel.text = "\(Int(temperature.day))°C"
        nightTemperatureLabel.text = "\(Int(temperature.night))°C"
        
        let realm = try! Realm()
        
        if let image = realm.objects(ImageStorage.self).filter("weather == %@", weather).first {
            weatherImageView.image = UIImage(data: image.data)
        } else {
            weatherImageView.load(url: iconURL) { image in
                let imageModel = ImageStorage()
                imageModel.data = image.pngData() ?? Data()
                imageModel.weather = weather

                try! realm.write {
                    realm.add(imageModel)
                }
            }
        }
    }
}
