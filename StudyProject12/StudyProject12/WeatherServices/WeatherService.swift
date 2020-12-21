//
//  WeatherService.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 17.12.2020.
//

import Foundation
import UIKit

protocol WeatherService {
    
    func loader(completion: @escaping (Result<WeatherForecast, WeatherError>) -> Void)
}

enum WeatherError: Error {
    case unavailableURL
    case noDataAvailable
    case canNotProcessData
}
