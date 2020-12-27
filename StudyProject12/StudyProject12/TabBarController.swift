//
//  TabBarController.swift
//  StudyProject12
//
//  Created by Nikolai Faustov on 17.12.2020.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherController0 = weatherViewController(AlamofireWeatherService(),
                                                       systemImageName: "cloud.sun", title: "Alamofire", tag: 0)
        let weatherController1 = weatherViewController(URLSessionWeatherService(decoder: HandWeatherDecoder()),
                                                       systemImageName: "cloud.sun.fill", title: "URLSession", tag: 1)
        let weatherController2 = weatherViewController(URLSessionWeatherService(decoder: CodableWeatherDecoder()),
                                                       systemImageName: "smoke.fill", title: "JSONDecoder", tag: 2)
        let weatherController3 = weatherViewController(APIKitWeatherService(),
                                                       systemImageName: "smoke", title: "APIKit", tag: 3)
        
        viewControllers = [weatherController0, weatherController1, weatherController2, weatherController3]
    }
    
    func weatherViewController(_ service: WeatherService, systemImageName: String, title: String, tag: Int) -> WeatherViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        let image = UIImage(systemName: systemImageName)
        vc.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        vc.weatherService = service
        return vc
    }
}
