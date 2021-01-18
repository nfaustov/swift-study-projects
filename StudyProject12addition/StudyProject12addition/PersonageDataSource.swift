//
//  PersonageDataSource.swift
//  StudyProject12addition
//
//  Created by Nikolai Faustov on 14.01.2021.
//

import UIKit

class PersonageDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    private let fetcher = PersonageFetcher()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 671
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonageCell.reuseIdentifier, for: indexPath) as! PersonageCell

        let id = indexPath.row + 1
        cell.representedId = id
        
        // Проверяем, возможно fetcher уже получил данные для этого id
        if let fetchedData = fetcher.fetchedData(for: id) {
            // Данные загружены и закэшированы, используем их
            cell.configure(from: fetchedData)
            print("Loaded personage: \(fetchedData.name) from cache")
        } else {
            // Данных нет. Загружаем их
            fetcher.fetchPersonage(id) { personage in
                DispatchQueue.main.async {
                    cell.configure(from: personage)
                    print("Loaded personage: \(String(describing: personage?.name)) directly from API")
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
