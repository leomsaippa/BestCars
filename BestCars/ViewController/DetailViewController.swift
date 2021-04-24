//
//  DetailViewController.swift
//  BestCars
//
//  Created by Leonardo Saippa on 20/04/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var test = false
    var currentCar: CarModel!
    
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var priceTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var backBtn: UIBarButtonItem!
    
    @IBOutlet weak var favBtn: UIBarButtonItem!
    
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

    @IBAction func onBackBtnClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onFavBtnClicked(_ sender: Any) {
     
        if(!test){
            favBtn.image = UIImage(systemName: "star")
            let leo =  UserDefaults.standard.integer(forKey: "id")
            
            print("test \(leo)")

            if(leo != 0) {
                UserDefaults.standard.removeObject(forKey: "id")

            }
          

           // favBtn.title = "Text"
        } else {
            favBtn.image = UIImage(systemName: "star.fill")
            UserDefaults.standard.set(currentCar.id, forKey: "id")

        }
        test = !test

        //favBtn.image = img
        
    }
    
}
