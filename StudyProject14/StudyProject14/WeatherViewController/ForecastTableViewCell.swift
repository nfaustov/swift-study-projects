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
    
    func configure(_ forecast: Daily) {
        weekDayLabel.text = dateFormatter.string(from: forecast.date)
        dayTemperatureLabel.text = "\(Int(forecast.dayTemperature))°C"
        nightTemperatureLabel.text = "\(Int(forecast.nightTemperature))°C"
        
        let realm = try! Realm()
        
        weatherImageView.image = UIImage(data: forecast.imageData)
        
        if weatherImageView.image == nil {
            guard let url = URL(string: "https://openweathermap.org/img/wn/\(forecast.imageName)@2x.png") else { return }
            weatherImageView.load(url: url) { image in
                try! realm.write {
                    forecast.imageData = image.pngData() ?? Data()
                }
                print("Cell image loaded from URL")
            }
        } else {
           print("Cell image loaded from Realm")
        }
        
    }
}
