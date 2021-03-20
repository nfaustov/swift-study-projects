//
//  WeatherViewController.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 16.03.2021.
//

import UIKit
import RealmSwift

final class WeatherViewController: UIViewController {
    private let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        return formatter
    }()
    
    let realm = try! Realm()

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
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
        
        forecastTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let forecast = realm.objects(WeatherForecast.self).first {
            configure(forecast: forecast)
            print("Configured from Realm")
        }
        
        WeatherService.load { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error): print(error)
            case .success(let response):
                DispatchQueue.main.async {
                    guard let forecast = self.getForecast(from: response) else { return }
                    self.configure(forecast: forecast)
                    print("Configured from URLSession")
                }
            }
        }
    }
    
    private var dailyForecast = [Daily]() {
        didSet {
            self.forecastTableView.reloadData()
        }
    }
    
    private func transform(_ response: DailyForecast) -> Daily {
        let daily = Daily()
        daily.date = response.dt
        daily.dayTemperature = response.temp.day
        daily.nightTemperature = response.temp.night
        guard let weather = response.weather.first else { return daily }
        daily.imageName = weather.icon
        
        return daily
    }
    
    private func getForecast(from response: WeeklyForecastResponse) -> WeatherForecast? {
        guard let weather = response.current.weather.first,
              let iconURL = URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png") else { return nil }
        
        let forecast = WeatherForecast()
        
        forecast.temperature = response.current.temp
        forecast.feelsLike = response.current.feelsLike
        forecast.pressure = response.current.pressure
        forecast.humidity = response.current.humidity
        forecast.windSpeed = response.current.windSpeed
        forecast.sunrise = response.current.sunrise
        forecast.sunset = response.current.sunset
        
        let daily = response.daily.map(transform(_:))
        
        try! realm.write {
            realm.add(forecast)
            forecast.dailyForecast.removeAll()
            forecast.dailyForecast.append(objectsIn: daily)
        }

        weatherImageView.load(url: iconURL) { [weak self] image in
            try! self?.realm.write {
                forecast.imageData = image.pngData() ?? Data()
            }
        }
        
        return forecast
    }
    
    private func configure(forecast: WeatherForecast) {
        dailyForecast = Array(forecast.dailyForecast)
        
        temperatureLabel.text = "\(Int(forecast.temperature))°C"
        feelsLikeLabel.text = "\(forecast.feelsLike)°C"
        windLabel.text = "\(Int(forecast.windSpeed))м/с"
        humidityLabel.text = "\(forecast.humidity)%"
        pressureLabel.text = "\(Int(Double(forecast.pressure) * 0.75))мм рт. ст."
        sunriseLabel.text = dateFormatter.string(from: forecast.sunrise)
        sunsetLabel.text = dateFormatter.string(from: forecast.sunset)

        if weatherImageView.image == nil {
            weatherImageView.image = UIImage(data: forecast.imageData)
        }
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dailyForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastTableViewCell
        cell.configure(dailyForecast[indexPath.row])
        
        return cell
    }
}
