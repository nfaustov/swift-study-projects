//
//  TableViewController.swift
//  StudyProject10
//
//  Created by Nikolai Faustov on 01.06.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        settingsTableView.rowHeight = 40
        settingsTableView.sectionHeaderHeight = 10
    }
    
    let sections: [[Cell]] = [
        [
            Cell(color: .systemOrange, imageName: "airplane", name: "Авиарежим", switchOption: true),
            Cell(color: .systemBlue, imageName: "wifi", name: "Wi-Fi", textStatus: "Anvics-YOTA"),
            Cell(color: .systemBlue, imageName: "radiowaves.right", name: "Bluetooth", textStatus: "Вкл."),
            Cell(color: .systemGreen, imageName: "antenna.radiowaves.left.and.right", name: "Сотовая связь"),
            Cell(color: .systemGreen, imageName: "personalhotspot", name: "Режим модема")
        ],
        [
            Cell(color: .systemRed, imageName: "app.badge", name: "Уведомления"),
            Cell(color: .systemRed, imageName: "speaker.3.fill", name: "Звуки, тактильные сигналы"),
            Cell(color: .systemIndigo, imageName: "moon.fill", name: "Не беспокоить"),
            Cell(color: .systemIndigo, imageName: "hourglass", name: "Экранное время")
        ],
        [
            Cell(color: .systemGray, imageName: "gear", name: "Основные", imageStatusName: "1.circle.fill"),
            Cell(color: .systemGray, imageName: "rectangle.grid.1x2", name: "Пункт управления"),
            Cell(color: .systemBlue, imageName: "textformat.size", name: "Экран и яркость")
        ],
        [
            Cell(color: .systemOrange, imageName: "airplane", name: "Авиарежим", switchOption: true),
            Cell(color: .systemBlue, imageName: "wifi", name: "Wi-Fi", textStatus: "Anvics-YOTA"),
            Cell(color: .systemBlue, imageName: "radiowaves.right", name: "Bluetooth", textStatus: "Вкл."),
            Cell(color: .systemGreen, imageName: "antenna.radiowaves.left.and.right", name: "Сотовая связь"),
            Cell(color: .systemGreen, imageName: "personalhotspot", name: "Режим модема")
        ]
    ]
}

extension TableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SettingsTableViewCell
        cell.configureView(fromModel: sections[indexPath.section][indexPath.row])
        
        return cell
    }
}




