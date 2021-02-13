//
//  PersonageDataSource.swift
//  StudyProject12addition
//
//  Created by Nikolai Faustov on 14.01.2021.
//

import UIKit

class PersonageDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    private let fetcher = PersonageFetcher()
    
    private let personagesCount: Int
    
    init(dataCount: Int) {
        personagesCount = dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personagesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonageCell.reuseIdentifier, for: indexPath) as! PersonageCell

        let id = indexPath.row + 1
        
        // Проверяем, возможно fetcher уже получил данные для этого id
        if let fetchedData = fetcher.fetchedData(for: id) {
            // Данные загружены и закэшированы, используем их
            cell.configure(from: fetchedData)
            print("Loaded personage id\(fetchedData.id) from cache")
        } else {
            // Данных нет. Загружаем их
            fetcher.fetchPersonage(id) { personage in
                guard let personage = personage else { return }
                
                DispatchQueue.main.async {
                    cell.configure(from: personage)
                    print("Loaded personage id\(personage.id) directly from API")
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            fetcher.fetchPersonage(indexPath.row + 1)
        }
        print("Prefetching \(indexPaths.count) personages")
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            fetcher.cancelFetch(indexPath.row + 1)
            print("Cancel prefetching personages")
        }
    }
}
