//
//  AlamofireWeatherService.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 16.12.2020.
//

import UIKit
import Alamofire

final class AlamofireWeatherService: WeatherService {
    
    func load(completion: @escaping (Result<WeatherForecast, WeatherError>) -> Void) {
        let APIKey = "3d1181b648f850729ee6c3a6b082bb57"
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=55.753960&lon=37.620393&exclude=minutely,hourly,alerts&units=metric&lang=ru&appid=\(APIKey)"
        
        AF.request(url).responseJSON { response in
            guard let objects = response.value else {
                completion(.failure(.noDataAvailable))
                return
            }
            guard let dictionary = objects as? NSDictionary,
                  let weatherForecast = WeatherForecast(from: dictionary) else {
                completion(.failure(.canNotProcessData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(weatherForecast))
            }
        }
    }
}
