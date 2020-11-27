//
//  ForecastWeatherLoader.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 27.11.2020.
//

import Foundation

protocol ForecastWeatherLoaderDelegate: AnyObject {
    func loaded(forecast: WeatherForecast)
}

class ForecastWeatherLoader {
    
    weak var delegate: ForecastWeatherLoaderDelegate?
    
    init() {
        let APIKey = "3d1181b648f850729ee6c3a6b082bb57"
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.753960&lon=37.620393&exclude=minutely,hourly,alerts&units=metric&lang=ru&appid=\(APIKey)") else {
            fatalError("Can't find URL")
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let dictionary = json as? NSDictionary {
                    if let weatherForecast = WeatherForecast(from: dictionary) {
                        DispatchQueue.main.async {
                            self.delegate?.loaded(forecast: weatherForecast)
                        }
                    }
                }
            }
        }
        
        task.resume()
    }
}
