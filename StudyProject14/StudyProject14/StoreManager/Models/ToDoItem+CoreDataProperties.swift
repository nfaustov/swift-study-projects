//
//  ToDoItem+CoreDataProperties.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 15.03.2021.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var title: String
    @NSManaged public var isDone: Bool

}

extension ToDoItem : Identifiable {

}

extension ToDoItem: ModelType {}
