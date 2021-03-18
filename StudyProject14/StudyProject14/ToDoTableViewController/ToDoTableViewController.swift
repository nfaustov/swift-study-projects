//
//  ToDoTableViewController.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 08.03.2021.
//

import UIKit

final class ToDoTableViewController<T>: UITableViewController where T: DataBaseManager {
    private var dataBaseManager: T
    private var items: [T.Model]

    private var itemCount = 0
    
    private let footerHeight: CGFloat = 50
    
    init(dataBaseManager: T) {
        self.dataBaseManager = dataBaseManager
        items = dataBaseManager.load()
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemCount = items.count

        tableView.register(ToDoItemTableViewCell.self, forCellReuseIdentifier: ToDoItemTableViewCell.reuseIdentifier)
        
        tableView.rowHeight = 50
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoItemTableViewCell.reuseIdentifier, for: indexPath) as! ToDoItemTableViewCell
        cell.configure(items[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        footerHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: footerHeight))
        footerView.backgroundColor = .systemBackground
        
        let button = UIButton(frame: CGRect(x: 20, y: 5, width: footerView.frame.width - 40, height: footerHeight - 10))
        button.layer.cornerRadius = 10
        button.setTitle("Добавить задачу", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(addItem), for: .touchUpInside)
        footerView.addSubview(button)
        
        return footerView
    }
    
    @objc private func addItem() {
        itemCount += 1
        let item = dataBaseManager.add(objectWithTitle: "Задача \(itemCount)")
        items.append(item)
        
        let indexPath = IndexPath(row: items.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteItem(at: indexPath)
        let swipeAtions = UISwipeActionsConfiguration(actions: [delete])
        
        return swipeAtions
    }
    
    private func deleteItem(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Удалить") { _,_,_ in
            self.dataBaseManager.delete(object: self.items[indexPath.row])
            self.items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return action
    }
}
