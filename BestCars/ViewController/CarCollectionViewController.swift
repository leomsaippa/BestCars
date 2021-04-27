//
//  CarCollectionViewController.swift
//  BestCars
//
//  Created by Leonardo Saippa on 26/04/21.
//

import UIKit
import CoreData
import MapKit


class CarCollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var fetchedResultsController: NSFetchedResultsController<Car>!
    var car: Car!
    let dataController = DataControllerInstance.dataControllerInstance.getDataController()

    var cars: [Car] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()

        collectionView.layoutMargins = UIEdgeInsets(top: 20, left: 8, bottom: 0, right: 0)

        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.layer.borderWidth = 1


        let space:CGFloat = 3.0
        let widthDimension = (view.frame.size.width - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: widthDimension, height: widthDimension)
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        do {
            let carData = try dataController?.fetchAllCars()
            cars = carData!
            print("Car data")
            let a = carData!.count
            for car in carData! {
                print("Carr")
                print(car.name)
            }
            print(a)
        } catch {
            print("Failed fetching cars")
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchedResultsController()
     
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fetchedResultsController = nil
    }
    // Setting up fetched results controller
       fileprivate func setupFetchedResultsController() {
           let fetchRequest:NSFetchRequest<Car> = Car.fetchRequest()
          
           if let car = car {
               let predicate = NSPredicate(format: "car == %@", car)
               fetchRequest.predicate = predicate
            
            print("\(car.name)")
           }
           let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
           fetchRequest.sortDescriptors = [sortDescriptor]
           
           fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                 managedObjectContext: dataController!.viewContext,
                                                                 sectionNameKeyPath: nil, cacheName: "car")
           fetchedResultsController.delegate = self
            print(fetchedResultsController.cacheName!)
            print(fetchedResultsController.fetchedObjects?.count ?? 0)

           do {
               try fetchedResultsController.performFetch()
           } catch {
               fatalError("The fetch could not be performed: \(error.localizedDescription)")
           }
       }
  
  

    @IBAction func OnPressedDone(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}



