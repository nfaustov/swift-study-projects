//
//  URLSessionWeatherService.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 16.12.2020.
//

import UIKit

final class URLSessionWeatherService: WeatherService {
    
    private let decoder: WeatherDecoder
    
    init(decoder: WeatherDecoder) {
        self.decoder = decoder
    }
    
    func load(completion: @escaping (Result<WeatherForecast, WeatherError>) -> Void) {
        let APIKey = "3d1181b648f850729ee6c3a6b082bb57"
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.753960&lon=37.620393&exclude=minutely,hourly,alerts&units=metric&lang=ru&appid=\(APIKey)") else {
            completion(.failure(.noDataAvailable))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            if let weatherForecast = self.decoder.decode(data) {
                completion(.success(weatherForecast))
            } else {
                completion(.failure(.canNotProcessData))
            }
        }
        
        task.resume()
    }
}
