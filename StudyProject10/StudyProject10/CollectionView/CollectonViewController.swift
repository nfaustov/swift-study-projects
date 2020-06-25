//
//  CollectonViewController.swift
//  StudyProject10
//
//  Created by Nikolai Faustov on 04.06.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class CollectonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Коллекция"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private var cells: [ProductModel] = [
        ProductModel(imageName: "1", productName: "Поездка в это прекрасное место", price: 25000, oldPrice: 40000),
        ProductModel(imageName: "2", productName: "Поездка в это прекрасное место", price: 25000, oldPrice: 40000),
        ProductModel(imageName: "3", productName: "Поездка в это прекрасное место", price: 25000, oldPrice: 40000),
        ProductModel(imageName: "4", productName: "Поездка в это прекрасное место", price: 25000, oldPrice: 40000),
        ProductModel(imageName: "5", productName: "Поездка в это прекрасное место", price: 25000, oldPrice: 40000),
        ProductModel(imageName: "6", productName: "Поездка в это прекрасное место", price: 25000, oldPrice: 40000),
    ]
}

extension CollectonViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (UIScreen.main.bounds.size.height - 60) / 3
        let width = (UIScreen.main.bounds.size.width - 60) / 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        cell.configureView(from: cells[indexPath.row])
        return cell
    }
    
    
}
