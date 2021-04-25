//
//  CarTableViewController.swift
//  BestCars
//
//  Created by Leonardo Saippa on 20/04/21.
//

import Foundation
import UIKit

class CarTableViewController: UITableViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let carViewCell = "CarViewCell"
    var cars: [CarModel] = []
    
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
        
        cell.textLabel!.text = self.cars[indexPath.row].name
        print("setting")
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select")
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let indexPath = self.tableView.indexPathForSelectedRow
        detailController.currentCar = self.cars[indexPath!.row]
        
           
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func getCars() {
        
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()

        MockyCall.getCars(completion: {(cars,totalPages, error) in
            if cars.count > 0 {
                print(cars)
                for car in cars {
                    self.cars = cars
                    let imageURL = URL(string: car.avatar)
                    guard let imageData = try? Data(contentsOf: imageURL!) else {
                        print("Image does not exist at \(String(describing: imageURL))")
                        return
                    }
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