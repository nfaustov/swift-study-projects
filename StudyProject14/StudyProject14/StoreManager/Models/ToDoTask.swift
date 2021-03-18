//
//  ToDoTask.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 15.03.2021.
//

import Foundation
import RealmSwift

class ToDoTask: Object {
    @objc dynamic var title = ""
}

extension ToDoTask: ModelType {}
