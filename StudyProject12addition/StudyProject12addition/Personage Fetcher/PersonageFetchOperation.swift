//
//  PersonageFetchOperation.swift
//  StudyProject12addition
//
//  Created by Nikolai Faustov on 14.01.2021.
//

import Foundation

class PersonageFetchOperation: Operation {
    let id: Int
    
    private(set) var fetchedData: Personage?
    
    private var task: URLSessionDataTask!
    
    enum OperationState {
        case ready
        case executing
        case finished
    }
    
    private var state: OperationState = .ready {
        willSet {
            willChangeValue(forKey: "isExecuting")
            willChangeValue(forKey: "isFinished")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isReady: Bool {
        state == .ready
    }
    override var isExecuting: Bool {
        state == .executing
    }
    override var isFinished: Bool {
        state == .finished
    }
    
    init(id: Int) {
        self.id = id
        super.init()
        
        let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)")!
        let request = URLRequest(url: url)
        task = URLSession.shared.dataTask(with: request) { [weak self] data,_,_ in
            guard let data = data else {
                fatalError()
            }
            
            guard let personage = try? JSONDecoder().decode(Personage.self, from: data) else {
                fatalError()
            }
            
            self?.fetchedData = personage
            
            self?.state = .finished
        }
    }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        
        state = .executing
        
        task.resume()
    }
    
    override func cancel() {
        super.cancel()
        
        task.cancel()
    }
}
