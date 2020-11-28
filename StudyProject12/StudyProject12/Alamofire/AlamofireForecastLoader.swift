//
//  AlamofireForecastLoader.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 28.11.2020.
//

import Foundation
import Alamofire

class AlamofireForecastLoader {
    
    init(completion: @escaping (WeatherForecast) -> Void) {
        let APIKey = "3d1181b648f850729ee6c3a6b082bb57"
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=55.753960&lon=37.620393&exclude=minutely,hourly,alerts&units=metric&lang=ru&appid=\(APIKey)"
        
        AF.request(url).responseJSON { response in
            if let objects = response.value,
               let dictionary = objects as? NSDictionary,
               let weatherForecast = WeatherForecast(from: dictionary) {
                    DispatchQueue.main.async {
                        completion(weatherForecast)
                    }
            }
        }
    }
}
