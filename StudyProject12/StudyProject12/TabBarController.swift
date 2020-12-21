//
//  TabBarController.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 17.12.2020.
//

import UIKit
import AlamofireImage

class TabBarController: UITabBarController {
    
    var weatherController0: WeatherViewController!
    var weatherController1: WeatherViewController!
    var weatherController2: WeatherViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        weatherController0 = (storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController)
        let image0 = UIImage(systemName: "cloud.sun")
        weatherController0.tabBarItem = UITabBarItem(title: "Alamofire", image: image0, tag: 0)
        weatherController0.weatherService = AlamofireWeatherService()
        weatherController0.weatherService.loader { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error): print(error)
            case .success(let forecast):
                self.weatherController0.configure(forecast: forecast)
                self.weatherController0.weatherImageView.af.setImage(withURL: forecast.currenticonURL)
            }

        }

        weatherController1 = (storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController)
        let image1 = UIImage(systemName: "cloud.sun.fill")
        weatherController1.tabBarItem = UITabBarItem(title: "URLSession", image: image1, tag: 1)
        
        weatherController2 = (storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController)
        let image2 = UIImage(systemName: "smoke.fill")
        weatherController2.tabBarItem = UITabBarItem(title: "JSONDecoder", image: image2, tag: 2)
        
        viewControllers = [weatherController0, weatherController1, weatherController2]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == weatherController1.tabBarItem {
            weatherController1.weatherService = URLSessionWeatherService()
            weatherController1.weatherService.loader { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error): print(error)
                case .success(let forecast):
                    self.weatherController1.configure(forecast: forecast)
                    self.weatherController1.weatherImageView.load(url: forecast.currenticonURL)
                }
            }
        } else if item == weatherController2.tabBarItem {
            weatherController2.weatherService = DecodingWeatherService()
            weatherController2.weatherService.loader { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error): print(error)
                case .success(let forecast):
                    self.weatherController2.configure(forecast: forecast)
                    self.weatherController2.weatherImageView.load(url: forecast.currenticonURL)
                }
            }
        }
    }
}
