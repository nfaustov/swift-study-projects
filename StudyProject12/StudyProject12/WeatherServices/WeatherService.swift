//
//  WeatherService.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 17.12.2020.
//

import UIKit

protocol WeatherService {
    func load(/*decoder: WeatherDecoder?, */completion: @escaping (Result<WeatherForecast, WeatherError>) -> Void)
}

protocol WeatherDecoder {
    func decode(_ raw: Data) -> WeatherForecast?
}

enum WeatherError: Error {
    case unavailableURL
    case noDataAvailable
    case canNotProcessData
}
