//
//  PageFetchOperation.swift
//  StudyProject12addition
//
//  Created by Nikolai Faustov on 24.01.2021.
//

import Foundation

class PageFetchOperation: Operation {
    let pageNumber: Int
    
    private(set) var fetchedPersonagesPage: [Personage]?
    
    private var task: URLSessionDataTask!
    
    enum OperationState {
        case ready
        case executing
        case finished
    }
    
    private var state: OperationState = .ready {
        willSet {
            willChangeValue(forKey: "isExecutinlg")
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
    
    init(pageNumber: Int) {
        self.pageNumber = pageNumber
        super.init()
        
        let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(pageNumber)")!
        let request = URLRequest(url: url)
        task = URLSession.shared.dataTask(with: request) { [weak self] data,_,_ in
            guard let data = data else {
                fatalError()
            }
            
            guard let personagesPage = try? JSONDecoder().decode(PersonagesPage.self, from: data) else {
                fatalError()
            }
            
            self?.fetchedPersonagesPage = personagesPage.results
            
            self?.state = .finished
            print("Page \(pageNumber) fetched")
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
