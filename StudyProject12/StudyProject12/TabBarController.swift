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
        
        let weatherController0 = setVC(systemImageName: "cloud.sun", title: "Alamofire", tag: 0)
        let weatherController1 = setVC(systemImageName: "cloud.sun.fill", title: "URLSession", tag: 1)
        let weatherController2 = setVC(systemImageName: "smoke.fill", title: "JSONDecoder", tag: 2)
        
        viewControllers = [weatherController0, weatherController1, weatherController2]
    }
    
    func setVC(systemImageName: String, title: String, tag: Int) -> WeatherViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        let image = UIImage(systemName: systemImageName)
        vc.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        return vc
    }
}
