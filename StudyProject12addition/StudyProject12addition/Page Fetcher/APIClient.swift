//
//  APIClient.swift
//  StudyProject12addition
//
//  Created by Nikolai Faustov on 25.01.2021.
//

import Foundation

class APIClient {
    static func getDataCount(completion: @escaping (Int) -> Void) {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data,_,_ in
            guard let data = data else { fatalError() }
            
            guard let pagination = try? JSONDecoder().decode(Pagination.self, from: data) else {
                fatalError()
            }
            
            DispatchQueue.main.async {
                completion(pagination.info.count)
            }
        }
        
        task.resume()
    }
}
