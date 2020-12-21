//
//  URLSessionWeatherService.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 16.12.2020.
//

import Foundation

class URLSessionWeatherService: WeatherService {
    
    func loader(completion: @escaping (Result<WeatherForecast, WeatherError>) -> Void) {
        let APIKey = "3d1181b648f850729ee6c3a6b082bb57"
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.753960&lon=37.620393&exclude=minutely,hourly,alerts&units=metric&lang=ru&appid=\(APIKey)") else {
            completion(.failure(.unavailableURL))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let dictionary = json as? NSDictionary, let weatherForecast = WeatherForecast(from: dictionary) {
                DispatchQueue.main.async {
                    completion(.success(weatherForecast))
                }
            } else {
                completion(.failure(.canNotProcessData))
            }
        }
        
        task.resume()
    }
}
