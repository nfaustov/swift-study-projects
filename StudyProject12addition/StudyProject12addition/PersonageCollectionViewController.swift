//
//  PersonageCollectionViewController.swift
//  StudyProject12addition
//
//  Created by Nikolai Faustov on 14.01.2021.
//

import UIKit


class PersonageCollectionViewController: UICollectionViewController {
//    var dataSource: PersonageDataSource!
    var dataSource: PersonagesCollectionDataSource!
    
    var personagesCount = 0 {
        didSet {
//            dataSource = PersonageDataSource(dataCount: personagesCount)
            dataSource = PersonagesCollectionDataSource(dataCount: personagesCount)
            collectionView.dataSource = dataSource
            collectionView.prefetchDataSource = dataSource
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PaginationInfo.getPersonagesCount { [weak self] count in
            self?.personagesCount = count
        }
    }
}

extension PersonageCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 480)
    }
}
