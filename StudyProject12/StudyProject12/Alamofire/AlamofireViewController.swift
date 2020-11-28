//
//  AlamofireViewController.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 26.11.2020.
//

import UIKit

class AlamofireViewController: UIViewController {
    
    let dateFormatter = DateFormatter()

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateFormat = "H:mm"
        
        cityLabel.text = "Москва"
        
        _ = AlamofireForecastLoader { (forecast) in
            self.dailyForecast = forecast.dailyForecast
            self.weatherDescriptionLabel.text = forecast.weatherDescription
            self.temperatureLabel.text = "\(Int(forecast.currentTemperature))°C"
            self.feelsLikeLabel.text = "\(Int(forecast.currentFeelsLike))°C"
            self.windLabel.text = "\(forecast.currentWindSpeed)м/с"
            self.humidityLabel.text = "\(forecast.currentHumidity)%"
            self.pressureLabel.text = "\(Int(Double(forecast.currentPressure) * 0.75))мм рт. ст."
            self.sunriseLabel.text = self.dateFormatter.string(from: forecast.currentSunrise)
            self.sunsetLabel.text = self.dateFormatter.string(from: forecast.currentSunset)
            self.weatherImageView.load(url: forecast.currenticonURL)
        }
        
        forecastTableView.dataSource = self
    }

    var dailyForecast = [Forecast]() {
        didSet {
            forecastTableView.reloadData()
        }
    }
}

extension AlamofireViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastTableViewCell
        cell.configure(dailyForecast[indexPath.row])
        return cell
    }
}
