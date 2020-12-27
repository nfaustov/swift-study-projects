//
//  HandWeatherDecoder.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 22.12.2020.
//

import Foundation

final class HandWeatherDecoder: WeatherDecoder {
    
    func decode(_ raw: Data) -> WeatherForecast? {
        guard let json = try? JSONSerialization.jsonObject(with: raw, options: .allowFragments),
              let dictionary = json as? NSDictionary,
              let weatherForecast = WeatherForecast(from: dictionary) else {
            return nil
        }
        
        return weatherForecast
    }
}
