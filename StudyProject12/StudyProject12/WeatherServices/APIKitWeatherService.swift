//
//  APIKitWeatherService.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 26.12.2020.
//

import Foundation
import APIKit

final class APIKitWeatherService: WeatherService {
    
    func load(completion: @escaping (Result<WeatherForecast, WeatherError>) -> Void) {
        
        let request = WeatherRequest()
        
        Session.send(request) { result in
            switch result {
            case .success(let weatherForecast):
                completion(.success(weatherForecast))
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct WeatherRequest: Request {
    
    typealias Response = WeatherForecast
    
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.753960&lon=37.620393&exclude=minutely,hourly,alerts&units=metric&lang=ru&appid=3d1181b648f850729ee6c3a6b082bb57")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return ""
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> WeatherForecast {
        guard let dictionary = object as? NSDictionary,
              let weather = WeatherForecast(from: dictionary) else {
            throw ResponseError.unexpectedObject(object)
        }

        return weather
    }
}
