//
//  CodableWeatherDecoder.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 22.12.2020.
//

import Foundation

final class CodableWeatherDecoder: WeatherDecoder {
    
    func decode(_ raw: Data) -> WeatherForecast? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        
        guard let weeklyForecast = try? decoder.decode(WeeklyForecastResponse.self, from: raw),
              let weatherForecast = WeatherForecast(from: weeklyForecast) else {
            return nil
        }

        return weatherForecast
    }
}
