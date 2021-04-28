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
        
        cell.textLabel!.text =  cars?[indexPath.row].name
        return cell
    }

    @objc func refresh() {

        DispatchQueue.main.async{
            self.cars = FavoriteCars.instance.getFavoriteCars()

            self.tableView.reloadData()
        }
    }
}
