//
//  FavoriteViewController.swift
//  BestCars
//
//  Created by Leonardo Saippa on 23/04/21.
//

import Foundation
import UIKit
import CoreData

class FavoriteViewController: UITableViewController {
    
    var cars: [Car]?

    var fetchedResultsController: NSFetchedResultsController<Car>!

    let favoriteViewCellId = "FavoriteViewCell"
    let dataController = DataControllerInstance.dataControllerInstance.getDataController()

    override func viewDidLoad() {
        super.viewDidLoad()
        

     //   cars = FavoriteCars.instance.getFavoriteCars()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        cars = FavoriteCars.instance.getFavoriteCars()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)


    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return cars?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: favoriteViewCellId, for: indexPath)
        
       // cell.textLabel!.text = self.carList[indexPath.row].name
        //print("setting")
        cell.textLabel!.text =  cars?[indexPath.row].name
        return cell
    }

    @objc func refresh() {

        DispatchQueue.main.async{
            self.cars = FavoriteCars.instance.getFavoriteCars()

            self.tableView.reloadData()
        }

   }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favoriteViewCellId , for: indexPath) as! FavoriteViewCell
//        print(indexPath)
//        cell.collectionImage.layoutMargins = UIEdgeInsets(top: 20, left: 8, bottom: 0, right: 0)
//        cell.collectionNameText.text = cars[indexPath.row].name
//
//        //cell.nameTextField.text = "test"
//       return cell
//    }
//
//      override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Click item")
////             self.performSegue(withIdentifier: "memeCollectionVCtoDetailVC", sender: self)
//         }
    
//
//    fileprivate func setupFetchedResultsController() {
//        let fetchRequest:NSFetchRequest<Car> = Car.fetchRequest()
//
////        if let car = currentCar {
////            let predicate = NSPredicate(format: "car == %@", car)
////            fetchRequest.predicate = predicate
////
////            print("Name: \(car.objectID) \(car.price)")
////        }
//        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
//                                                              managedObjectContext: dataController!.viewContext,
//                                                              sectionNameKeyPath: nil, cacheName: "car")
//        fetchedResultsController.delegate = self
//     print(fetchedResultsController.cacheName!)
//     print(fetchedResultsController.fetchedObjects?.count ?? 0)
//
//        do {
//            try fetchedResultsController.performFetch()
//        } catch {
//            fatalError("The fetch could not be performed: \(error.localizedDescription)")
//        }
//    }
    
}
