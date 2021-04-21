//
//  TableViewController.swift
//  BestCars
//
//  Created by Leonardo Saippa on 19/04/21.
//

import Foundation
import UIKit

class TableViewController: UITableViewController, {
    let carCellID = "CarViewCell"

    var cars: [Car] = []
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
     //   getCars()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: carCellID, for: indexPath)
        print(indexPath)
        
        print("setting")
       // cell.carTextField!.text = "Test"
                   
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            print("remove")

        }
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
//
//        let indexPath = self.tableView.indexPathForSelectedRow
//        detailController.currentMeme = self.memes[indexPath!.row]
//
//        self.navigationController!.pushViewController(detailController, animated: true)
        print("On click")
    }
    
    
    func getCars() {
        

        MockyCall.getCars(completion: {(cars,totalPages, error) in
            if cars.count > 0 {
                for car in cars {
                    let imageURL = URL(string: "https://s3.amazonaws.com/uifaces/faces/twitter/larrybolt/128.jpg")
                    guard let imageData = try? Data(contentsOf: imageURL!) else {
                        print("Image does not exist at \(String(describing: imageURL))")
                        return
                    }
                }
            }
        })
        
    }
    
}
