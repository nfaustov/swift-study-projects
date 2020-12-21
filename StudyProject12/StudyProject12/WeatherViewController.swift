//
//  WeatherViewController.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 19.12.2020.
//

import UIKit

class WeatherViewController: UIViewController {

    var weatherService: WeatherService!
    
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
        
        forecastTableView.dataSource = self
    }
    
    var dailyForecast = [DailyForecast]() {
        didSet {
            forecastTableView.reloadData()
        }
    }
    
    func configure(forecast: WeatherForecast) {
        dailyForecast = forecast.dailyForecast
        weatherDescriptionLabel.text = forecast.weatherDescription
        temperatureLabel.text = "\(Int(forecast.currentTemperature))°C"
        feelsLikeLabel.text = "\(Int(forecast.currentFeelsLike))°C"
        windLabel.text = "\(forecast.currentWindSpeed)м/с"
        humidityLabel.text = "\(forecast.currentHumidity)%"
        pressureLabel.text = "\(Int(Double(forecast.currentPressure) * 0.75))мм рт. ст."
        sunriseLabel.text = dateFormatter.string(from: forecast.currentSunrise)
        sunsetLabel.text = dateFormatter.string(from: forecast.currentSunset)
    }
    
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastTableViewCell
        cell.configure(dailyForecast[indexPath.row])
        return cell
    }
}
