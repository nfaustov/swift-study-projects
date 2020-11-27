//
//  DefaultViewController.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 26.11.2020.
//

import UIKit

class DefaultViewController: UIViewController {

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
        
        let loader = ForecastWeatherLoader()
        loader.delegate = self
    }

    var dailyForecast: [Forecast]! {
        didSet {
            forecastTableView.dataSource = self
        }
    }
}

extension DefaultViewController: ForecastWeatherLoaderDelegate {
    func loaded(forecast: WeatherForecast) {
        dailyForecast = forecast.dailyForecast
        weatherDescriptionLabel.text = forecast.currentWeatherDescription
        temperatureLabel.text = "\(Int(forecast.currentTemperature))°C"
        feelsLikeLabel.text = "\(Int(forecast.currentFeelsLike))°C"
        windLabel.text = "\(forecast.currentWindSpeed)м/с"
        humidityLabel.text = "\(forecast.currentHumidity)%"
        pressureLabel.text = "\(Int(Double(forecast.currentPressure) * 0.75))мм рт. ст."
        sunriseLabel.text = dateFormatter.string(from: forecast.currentSunrise)
        sunsetLabel.text = dateFormatter.string(from: forecast.currentSunset)
        weatherImageView.load(url: forecast.currenticonURL)
    }
}

extension DefaultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastTableViewCell
        cell.configure(dailyForecast[indexPath.row])
        return cell
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
