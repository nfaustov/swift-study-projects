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
        
        if let forecast = realm.objects(WeeklyForecastResponse.self).first {
            configure(forecast: forecast)
            print("Configured from Realm")
        }
        
        WeatherService.load { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error): print(error)
            case .success(let forecast):
                DispatchQueue.main.async {
                    self.configure(forecast: forecast)
                    print("Configured from URLSession")
                    
                    try! self.realm.write {
                        self.realm.add(forecast)
                    }
                }
            }
        }
    }
    
    private var dailyForecast = [DailyForecast]() {
        didSet {
            self.forecastTableView.reloadData()
        }
    }
    
    private func configure(forecast: WeeklyForecastResponse) {
        dailyForecast = Array(forecast.daily)
        
        guard let current = forecast.current,
              let weather = current.weather.first,
              let iconURL = URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png") else { return }

        temperatureLabel.text = "\(Int(current.temp))°C"
        feelsLikeLabel.text = "\(Int(current.feelsLike))°C"
        windLabel.text = "\(current.windSpeed)м/с"
        humidityLabel.text = "\(current.humidity)%"
        pressureLabel.text = "\(Int(Double(current.pressure) * 0.75))мм рт. ст."
        sunriseLabel.text = dateFormatter.string(from: current.sunrise)
        sunsetLabel.text = dateFormatter.string(from: current.sunset)

        if let image = realm.objects(ImageStorage.self).filter("weather == %@", weather).first {
            weatherImageView.image = UIImage(data: image.data)
        } else {
            weatherImageView.load(url: iconURL) { [weak self] image in
                guard let self = self else { return }

                let imageModel = ImageStorage()
                imageModel.data = image.pngData() ?? Data()
                imageModel.weather = weather

                try! self.realm.write {
                    self.realm.add(imageModel)
                }
            }
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
