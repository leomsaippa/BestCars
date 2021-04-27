//
//  CarCollectionViewCell.swift
//  BestCars
//
//  Created by Leonardo Saippa on 26/04/21.
//

import Foundation
import UIKit

class CarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionImage: UIImageView!
    
    @IBOutlet weak var collectionNameText: UILabel!
    
    static let reuseIdentifier = "CarCollectionViewCell"

}
