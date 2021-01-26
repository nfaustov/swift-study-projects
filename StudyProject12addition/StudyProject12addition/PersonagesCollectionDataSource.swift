//
//  PersonagesCollectionDataSource.swift
//  StudyProject12addition
//
//  Created by Nikolai Faustov on 24.01.2021.
//

import UIKit

class PersonagesCollectionDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    private let fetcher = PersonagesPageFetcher()
    
    private let personagesCount: Int
    
    private var pageNumber = 1
    private let personagesPerPage = 20
    
    init(dataCount: Int) {
        personagesCount = dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personagesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonageCell.reuseIdentifier, for: indexPath) as! PersonageCell
        
        let id = indexPath.row + 1

        if let fetchedData = fetcher.fetchedData(for: pageNumber) {
            for personage in fetchedData where personage.id == id {
                cell.configure(from: personage)
                print("Loaded personage id\(personage.id) from cache")
            }
        } else {
            fetcher.fetchPersonagesPage(pageNumber) { personages in
                guard let personage = personages.first(where: { $0.id == id }) else { return }
                
                DispatchQueue.main.async {
                    cell.configure(from: personage)
                    print("Loaded personage id\(personage.id) directly from API")
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths where indexPath.row % personagesPerPage == 0 {
            pageNumber = (indexPath.row + 1) / personagesPerPage + 1
            fetcher.fetchPersonagesPage(pageNumber)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths where indexPath.row % personagesPerPage == 0 {
            fetcher.cancelFetch(pageNumber: pageNumber)
        }
    }
}
