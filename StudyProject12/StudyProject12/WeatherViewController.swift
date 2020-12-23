//
//  WeatherViewController.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 19.12.2020.
//

import UIKit
import AlamofireImage

class WeatherViewController: UIViewController {

    var weatherService: WeatherService!
    
    private let dateFormatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "H:mm"
        return format
    }()
    
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
        
        cityLabel.text = "Москва"
        
        if tabBarItem.tag == 0 {
            weatherService = AlamofireWeatherService()
        } else if tabBarItem.tag == 1 {
            let decoder = HandWeatherDecoder()
            weatherService = URLSessionWeatherService(decoder: decoder)
        } else if tabBarItem.tag == 2 {
            let decoder = CodableWeatherDecoder()
            weatherService = URLSessionWeatherService(decoder: decoder)
        }
        
        weatherService.load { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error): print(error)
            case .success(let forecast):
                self.configure(forecast: forecast)
            }
        }
        
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
        weatherImageView.af.setImage(withURL: forecast.currenticonURL)
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
