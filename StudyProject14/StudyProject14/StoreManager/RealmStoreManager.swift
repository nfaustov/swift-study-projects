//
//  RealmStoreManager.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 13.03.2021.
//

import Foundation
import RealmSwift

final class RealmManager: DataBaseManager {
    let realm = try! Realm()

    func load() -> [ToDoTask] {
        let tasks = realm.objects(ToDoTask.self)
        return Array(tasks)
    }
    
    func add(objectWithTitle title: String) -> ToDoTask {
        let toDoTask = ToDoTask()
        toDoTask.title = title
        toDoTask.isDone = false
        save {
            self.realm.add(toDoTask)
        }
        
        return toDoTask
    }
    
    func save(changes: (() -> Void)?) {
        try! realm.write {
            changes?()
        }
    }
    
    func delete(object: ToDoTask) {
        try! realm.write {
            realm.delete(object)
        }
    }
}
