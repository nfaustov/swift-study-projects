//
//  WeatherForecast.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 27.11.2020.
//

import Foundation

class WeatherForecast {
    
    var dailyForecast = [DailyForecast]()
    
    var weatherDescription: String
    var currentTemperature: Double
    var currentFeelsLike: Double
    var currentWindSpeed: Double
    var currentHumidity: Int
    var currentPressure: Int
    var currentSunrise: Date
    var currentSunset: Date
    var currenticonURL: URL
    
    init?(from json: NSDictionary) {
        guard let current = json["current"] as? [String : Any],
              let weatherArray = current["weather"] as? [[String : Any]],
              let currentTemperature = current["temp"] as? Double,
              let currentFeelsLike = current["feels_like"] as? Double,
              let currentWindSpeed = current["wind_speed"] as? Double,
              let currentHumidity = current["humidity"] as? Int,
              let currentPressure = current["pressure"] as? Int,
              let currentSunrise = current["sunrise"] as? Int,
              let currentSunset = current["sunset"] as? Int,
              let weather = weatherArray.first,
              let description = weather["description"] as? String,
              let icon = weather["icon"] as? String,
              let iconURL = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") else { return nil }
        
        weatherDescription = description
        self.currentTemperature = currentTemperature
        self.currentFeelsLike = currentFeelsLike
        self.currentWindSpeed = currentWindSpeed
        self.currentHumidity = currentHumidity
        self.currentPressure = currentPressure
        self.currentSunrise = Date(timeIntervalSince1970: TimeInterval(currentSunrise))
        self.currentSunset = Date(timeIntervalSince1970: TimeInterval(currentSunset))
        currenticonURL = iconURL
        
        guard let daily = json["daily"] as? [[String : Any]] else { return nil }
        for day in daily {
            guard let forecastDate = day["dt"] as? Int,
                  let temperature = day["temp"] as? [String : Double],
                  let dayTemp = temperature["day"],
                  let nightTemp = temperature["night"],
                  let weatherArray = day["weather"] as? [[String : Any]],
                  let weather = weatherArray.first,
                  let icon = weather["icon"] as? String else { return nil }
            
            let date = Date(timeIntervalSince1970: TimeInterval(forecastDate))
            let temp = Temperature(day: dayTemp, night: nightTemp)
            let dailyWeather = Weather(icon: icon)
            let forecast = DailyForecast(dt: date, temp: temp, weather: [dailyWeather])
            dailyForecast.append(forecast)
        }
    }
    
    init?(from response: WeeklyForecastResponse) {
        dailyForecast = response.daily
        guard let weather = response.current.weather.first else { return nil }
        weatherDescription = weather.description ?? ""
        currentTemperature = response.current.temp
        currentFeelsLike = response.current.feelsLike
        currentWindSpeed = response.current.windSpeed
        currentHumidity = response.current.humidity
        currentPressure = response.current.pressure
        currentSunrise = response.current.sunrise
        currentSunset = response.current.sunset
        guard let iconURL = URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png") else { return nil}
        currenticonURL = iconURL
    }
}
