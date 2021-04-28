//
//  TabBarController.swift
//  BestCars
//
//  Created by Leonardo Saippa on 27/04/21.
//

import Foundation
import CoreData
import UIKit

class TabBarController: UITabBarController {
   
    let dataController = DataControllerInstance.dataControllerInstance.getDataController()

    @IBAction func btnLogoutClicked(_ sender: Any) {
                UdacityApiCall.logout {
                    self.deleteAllData("Car")

                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                   
                    }
                }
    }
                    
    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: true);
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try dataController!.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                dataController!.viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
}
