//
//  WeatherForecast.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 19.03.2021.
//

import Foundation
import RealmSwift

@objcMembers
class WeatherForecast: Object {
    dynamic var temperature: Double = 0.0
    dynamic var feelsLike: Double = 0.0
    dynamic var pressure = 0
    dynamic var humidity = 0
    dynamic var windSpeed: Double = 0.0
    dynamic var sunrise = Date()
    dynamic var sunset = Date()
    dynamic var imageData = Data()
    dynamic var dailyForecast = List<Daily>()
}

@objcMembers
class Daily: Object {
    dynamic var date = Date()
    dynamic var dayTemperature: Double = 0.0
    dynamic var nightTemperature: Double = 0.0
    dynamic var imageName = ""
    dynamic var imageData = Data()
}
