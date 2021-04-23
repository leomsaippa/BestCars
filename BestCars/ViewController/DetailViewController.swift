//
//  DetailViewController.swift
//  BestCars
//
//  Created by Leonardo Saippa on 20/04/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var currentCar: Car!
    
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var priceTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextView.text = currentCar.name
        priceTextView.text = currentCar.price
        descriptionTextView.text = currentCar.description
        
        let url = URL(string: currentCar.avatar)
        
        if let imageData = try? Data(contentsOf: url!) {
            let image = UIImage(data: imageData)!
            detailImage.image = image
        }
    }

}
