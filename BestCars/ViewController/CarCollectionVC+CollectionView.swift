//
//  CarCollectionVC+CollectionView.swift
//  BestCars
//
//  Created by Leonardo Saippa on 26/04/21.
//

import Foundation
import UIKit
extension CarCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = fetchedResultsController.sections?[section].numberOfObjects ?? 0
        print("Novo count \(count)")
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

       // CollectionView
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as! CarCollectionViewCell
        guard !(self.fetchedResultsController.fetchedObjects?.isEmpty)! else {
            print("images are already present.")
            return cell
        }
    
        // fetch core data
        let carData = self.fetchedResultsController.object(at: indexPath)

        
        cell.collectionNameText.text = carData.name
        let url = URL(string: carData.avatar!)

        if let imageData = try? Data(contentsOf: url!) {
            let image = UIImage(data: imageData)!
            //TODO: Fix image size 
            cell.collectionImage.image = image
            
            cell.collectionImage.sizeToFit()
        }

        return cell
    }

    /// Set up the Collection View.
    func setUpCollectionView() {
        // Set up Collection View
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        configureFlowLayout()
    }

    /// Set up the flow layout for the Collection View.
    func configureFlowLayout() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
         let space:CGFloat = 3.0
         let dimension = (view.frame.size.width - (2 * space)) / 3.0
         flowLayout.minimumInteritemSpacing = space
         flowLayout.minimumLineSpacing = space
         flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        }
    }
}

