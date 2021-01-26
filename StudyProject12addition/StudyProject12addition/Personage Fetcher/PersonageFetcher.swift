//
//  PersonageFetcher.swift
//  StudyProject12addition
//
//  Created by Nikolai Faustov on 14.01.2021.
//

import Foundation

class PersonageFetcher {
    // Очередь операций, которая состоит из fetchQueue и вызовов completionHandlers
    private let serialAccessQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    // Очередь операций, которая состоит из PersonageFetchOperation
    private let fetchQueue = OperationQueue()
    
    typealias CompletionHandler = (Personage?) -> Void
    // Словарь замыканий, которые вызываются, когда мы получили данные по нужному id
    private var completionHandlers = [Int: CompletionHandler]()
    // В кэше хранятся полученные данные
    private var cache = NSCache<NSNumber, Personage>()
    
    func fetchedData(for id: Int) -> Personage? {
        return cache.object(forKey: id as NSNumber)
    }
    
    func fetchPersonage(_ id: Int, completion: CompletionHandler? = nil) {
        serialAccessQueue.addOperation {
            if let completion = completion {
                self.completionHandlers[id] = completion
            }
            
            self.fetchData(for: id)
        }
    }
    
    private func fetchData(for id: Int) {
        // Если операция с запросом уже существует, то дальше не идем
        guard operation(for: id) == nil else { return }
        
        if let data = fetchedData(for: id) {
            // Если объект уже в кэше, то вызываем completion handler c этим объектом
            invokeCompletionHandlers(for: id, with: data)
        } else {
            // Добавляем запрос в очередь
            let operation = PersonageFetchOperation(id: id)
            // Добавляем completion block к операции, чтобы закэшировать загруженные объекты
            // и вызвать соответствующие completion handler'ы
            operation.completionBlock = { [weak operation] in
                guard let fetchedData = operation?.fetchedData else { return }
                self.cache.setObject(fetchedData, forKey: id as NSNumber)
                
                self.serialAccessQueue.addOperation {
                    self.invokeCompletionHandlers(for: id, with: fetchedData)
                }
            }
            
            fetchQueue.addOperation(operation)
        }
    }
    
    func cancelFetch(_ id: Int) {
        serialAccessQueue.addOperation {
            self.fetchQueue.isSuspended = true
            defer {
                self.fetchQueue.isSuspended = false
            }
            
            self.operation(for: id)?.cancel()
            self.completionHandlers[id] = nil
        }
    }
    
    private func operation(for id: Int) -> PersonageFetchOperation? {
        for case let fetchOperation as PersonageFetchOperation in fetchQueue.operations
            where !fetchOperation.isCancelled && fetchOperation.id == id {
            return fetchOperation
        }

        return nil
    }
    
    private func invokeCompletionHandlers(for id: Int, with fetchedData: Personage) {
        if let completionHandlers = completionHandlers[id] {
            completionHandlers(fetchedData)
        }
        
        completionHandlers[id] = nil
    }
}
