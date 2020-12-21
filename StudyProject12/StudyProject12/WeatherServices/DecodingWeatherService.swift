//
//  DecodingWeatherService.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 19.12.2020.
//

import Foundation

class DecodingWeatherService: WeatherService {
    
    func loader(completion: @escaping (Result<WeatherForecast, WeatherError>) -> Void) {
        let APIKey = "3d1181b648f850729ee6c3a6b082bb57"
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.753960&lon=37.620393&exclude=minutely,hourly,alerts&units=metric&lang=ru&appid=\(APIKey)") else {
            completion(.failure(.unavailableURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .secondsSince1970
                
                let weeklyForecast = try decoder.decode(WeeklyForecastResponse.self, from: jsonData)
                guard let weatherForecast = WeatherForecast(from: weeklyForecast) else { return }
                DispatchQueue.main.async {
                    completion(.success(weatherForecast))
                }
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        
        task.resume()
    }
}
