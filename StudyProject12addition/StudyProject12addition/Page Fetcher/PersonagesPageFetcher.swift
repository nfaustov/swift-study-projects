//
//  PersonagesPageFetcher.swift
//  StudyProject12addition
//
//  Created by Nikolai Faustov on 24.01.2021.
//

import Foundation

class PersonagesPageFetcher {
    private let serialAccessQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    private let fetchQueue = OperationQueue()
    
    private var cache = NSCache<NSNumber, NSArray>()
    
    func fetchedData(for pageNumber: Int) -> [Personage]? {
        guard let personages = cache.object(forKey: pageNumber as NSNumber) as? [Personage] else {
            return nil
        }
        
        return personages
    }
    
    func fetchPersonagesPage(_ pageNumber: Int, completion: (([Personage]) -> Void)? = nil) {
        serialAccessQueue.addOperation {
            guard self.operation(for: pageNumber) == nil else { return }

            if let data = self.fetchedData(for: pageNumber) {
                guard let completion = completion else { return }
                completion(data)
            } else {
                let operation = PageFetchOperation(pageNumber: pageNumber)
                
                operation.completionBlock = { [weak operation] in
                    guard let fetchedData = operation?.fetchedPersonagesPage else { return }
                    self.cache.setObject(fetchedData as NSArray, forKey: pageNumber as NSNumber)

                    self.serialAccessQueue.addOperation {
                        guard let completion = completion else { return }
                        completion(fetchedData)
                    }
                }
                
                self.fetchQueue.addOperation(operation)
            }
        }
    }
    
    func cancelFetch(pageNumber: Int) {
        serialAccessQueue.addOperation {
            self.fetchQueue.isSuspended = true
            defer {
                self.fetchQueue.isSuspended = false
            }
            
            self.operation(for: pageNumber)?.cancel()
        }
    }
    
    private func operation(for pageNumber: Int) -> PageFetchOperation? {
        for case let fetchOperation as PageFetchOperation in fetchQueue.operations
        where !fetchOperation.isCancelled && fetchOperation.pageNumber == pageNumber {
            return fetchOperation
        }
        
        return nil
    }
}
