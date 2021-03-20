//
//  WeatherForecastResponse.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 16.03.2021.
//

import Foundation

struct WeeklyForecastResponse: Decodable {
    var current: CurrentWeather
    var daily: [DailyForecast]
}

struct CurrentWeather: Decodable {
    var weather: [Weather]
    var sunrise: Date
    var sunset: Date
    var temp: Double
    var feelsLike: Double
    var pressure: Int
    var humidity: Int
    var windSpeed: Double
}

struct DailyForecast: Decodable {
    var dt: Date
    var temp: Temperature
    var weather: [Weather]
}

struct Temperature: Decodable {
    var day: Double
    var night: Double
}

struct Weather: Decodable {
    var icon: String
}
