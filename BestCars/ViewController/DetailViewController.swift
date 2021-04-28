//
//  DetailViewController.swift
//  BestCars
//
//  Created by Leonardo Saippa on 20/04/21.
//

import Foundation
import UIKit
import CoreData

class DetailViewController: UIViewController,NSFetchedResultsControllerDelegate {
    var test = false
    var currentCar: Car!
    var fetchedResultsController: NSFetchedResultsController<Car>!

    let dataController = DataControllerInstance.dataControllerInstance.getDataController()
    var isFav = false

    
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var priceTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var backBtn: UIBarButtonItem!
    
    @IBOutlet weak var favBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextView.text = currentCar.name
        var price = currentCar.price!
        price.insert("$", at: price.startIndex) // prints !hello
        price.insert(",", at: price.index(price.startIndex, offsetBy: 3))
        priceTextView.text = price

        descriptionTextView.text = currentCar.descriptionText
        
        let url = URL(string: currentCar.avatar!)
        
        if let imageData = try? Data(contentsOf: url!) {
            let image = UIImage(data: imageData)!
            detailImage.image = image
        }
        let array =  UserDefaults.standard.stringArray(forKey: currentCar.id!)
        print("current \(array?[0])")
        print("current \(array?[1])")
      
        if(array?[0] != nil){
            isFav =  UserDefaults.standard.bool(forKey: array![0])
            print("isFav \(isFav)")
        }
        favBtn.image = UIImage(systemName: "star")

        if(isFav){
            favBtn.image = UIImage(systemName: "star.fill")
        }
    }

    @IBAction func onBackBtnClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onFavBtnClicked(_ sender: Any) {
        
      
        if(isFav) {
            favBtn.image = UIImage(systemName: "star")
            UserDefaults.standard.removeObject(forKey: currentCar.id!)
            UserDefaults.standard.removeObject(forKey: currentCar.name!)
        } else {
            favBtn.image = UIImage(systemName: "star.fill")
            UserDefaults.standard.setValue(true, forKey: currentCar.name!)
            var array = [currentCar.name,currentCar.avatar]


            var fav = FavoriteCars.instance.getFavoriteCars()
            fav?.append(currentCar)
            FavoriteCars.instance.setFavoriteCars(cars: fav!)
            UserDefaults.standard.setValue(array, forKey: currentCar.id!)


            //save()

        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)

    }
    
    func save() {
        let managedContext = dataController?.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "Car", in: managedContext!)
      
        let car = NSManagedObject(entity: entity!,
                                   insertInto: managedContext)
    
        car.setValue(currentCar.name, forKeyPath: "name")
        car.setValue(currentCar.id, forKey: "id")
        car.setValue(currentCar.price, forKey: "price")
    }
}
