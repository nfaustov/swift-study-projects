//
//  WeatherService.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 16.03.2021.
//

import Foundation
import UIKit

final class WeatherService {
    enum WeatherError: Error {
        case unavailableURL
        case noDataAvailable
        case cannotProcessData
    }
    
    static func load(completion: @escaping (Result<WeeklyForecastResponse, WeatherError>) -> Void) {
        let baseURL = "https://api.openweathermap.org"
        let moscowLocation = "lat=55.753960&lon=37.620393"
        let options = "exclude=minutely,hourly,alerts&units=metric&lang=ru"
        let APIKey = "appid=3d1181b648f850729ee6c3a6b082bb57"
        
        guard let url = URL(string: "\(baseURL)/data/2.5/onecall?\(moscowLocation)&\(options)&\(APIKey)") else {
            completion(.failure(.unavailableURL))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .secondsSince1970

            guard let forecastResponse = try? decoder.decode(WeeklyForecastResponse.self, from: data) else {
                completion(.failure(.cannotProcessData))
                return
            }
            
            completion(.success(forecastResponse))
        }
        
        task.resume()
    }
}
