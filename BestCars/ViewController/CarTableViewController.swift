//
//  CarTableViewController.swift
//  BestCars
//
//  Created by Leonardo Saippa on 20/04/21.
//

import Foundation
import UIKit
import CoreData

class CarTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let carViewCell = "CarViewCell"
    var carList: [Car] = []

    let dataController = DataControllerInstance.dataControllerInstance.getDataController()
    
    override func viewDidLoad() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCars()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: carViewCell, for: indexPath)
        
        cell.textLabel!.text = self.carList[indexPath.row].name
        print("setting")
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select")
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let indexPath = self.tableView.indexPathForSelectedRow
        detailController.currentCar = self.carList[indexPath!.row]
        
           
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }
    
    func getCars() {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
          
        let managedContext = dataController!.persistentContainer.viewContext
          
        let fetchRequest:NSFetchRequest<Car> = Car.fetchRequest()

        do {
            let car = try managedContext.fetch(fetchRequest)
            if(car.count != 0) {

                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.carList = car
                self.tableView.reloadData()
                
                return
          }

          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        

        //TODO: Check before call
        MockyCall.getCars(completion: {(cars,totalPages, error) in
            if cars.count > 0 {
                print(cars)
                for car in cars {
                    let currentCar = Car(context: self.dataController!.viewContext)
                    let imageURL = URL(string: car.avatar)
                    guard let imageData = try? Data(contentsOf: imageURL!) else {
                        print("Image does not exist at \(String(describing: imageURL))")
                        return
                    }
                    currentCar.avatar = car.avatar
                    currentCar.id = car.id
                    currentCar.price = car.price
                    currentCar.name = car.name
                    currentCar.descriptionText = car.description
                    self.carList.append(currentCar)
                    
                    do {
                        try self.dataController!.viewContext.save()
                    } catch {
                        print("Unable to save the photo")
                    }
                    
                    
                    //self.cars = cars
                 
                    DispatchQueue.main.async {
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                        self.tableView.reloadData()
                        
                    }
                }
            }
        })
        
    }    
}
