//
//  WeatherForecastResponse.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 16.03.2021.
//

import Foundation
import RealmSwift

@objcMembers
class WeeklyForecastResponse: Object, Decodable {
    dynamic var current: CurrentWeather?
    dynamic var daily = List<DailyForecast>()
}

@objcMembers
class CurrentWeather: Object, Decodable {
    dynamic var weather = List<Weather>()
    dynamic var sunrise = Date()
    dynamic var sunset = Date()
    dynamic var temp: Double = 0.0
    dynamic var feelsLike: Double = 0.0
    dynamic var pressure = 0
    dynamic var humidity = 0
    dynamic var windSpeed: Double = 0.0
}

@objcMembers
class DailyForecast: Object, Decodable {
    dynamic var dt = Date()
    dynamic var temp: Temperature?
    dynamic var weather = List<Weather>()
}

@objcMembers
class Temperature: Object, Decodable {
    dynamic var day: Double = 0.0
    dynamic var night: Double = 0.0
}

@objcMembers
class Weather: Object, Decodable {
    dynamic var icon = ""
}

@objcMembers
class ImageStorage: Object {
    dynamic var data = Data()
    dynamic var weather: Weather?
}
