//
//  TabBarController.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 08.03.2021.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let nameViewController = viewController(
            NameViewController(),
            systemImageName: "person.fill",
            title: "NameViewController",
            tag: 0
        )
        let coreDataToDoTableViewController = viewController(
            ToDoTableViewController(dataBaseManager: CoreDataManager()),
            systemImageName: "list.bullet",
            title: "ToDoListCoreDataWay",
            tag: 1
        )
        let realmToDoTableViewController = viewController(
            ToDoTableViewController(dataBaseManager: RealmManager()),
            systemImageName: "list.star",
            title: "ToDoListRealmWay",
            tag: 2
        )
        let weatherViewController = viewController(
            weatherForecastViewController(),
            systemImageName: "cloud.fill",
            title: "WeatherViewController",
            tag: 3
        )

        viewControllers = [nameViewController, coreDataToDoTableViewController, realmToDoTableViewController, weatherViewController]
    }
    
    private func viewController(_ vc: UIViewController, systemImageName: String, title: String, tag: Int) -> UIViewController {
        let image = UIImage(systemName: systemImageName)
        vc.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        return vc
    }
    
    private func weatherForecastViewController() -> WeatherViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        
        return vc
    }

}
