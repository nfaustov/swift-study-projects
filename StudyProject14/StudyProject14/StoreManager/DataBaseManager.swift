//
//  DataBaseManager.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 13.03.2021.
//

import Foundation

protocol DataBaseManager {
    associatedtype Model: ModelType

    func load() -> [Model]
    func add(objectWithTitle: String) -> Model
    func save(changes: (() -> Void)?)
    func delete(object: Model)
}

protocol ModelType {
    var title: String { get set }
    var isDone: Bool { get set }
}

