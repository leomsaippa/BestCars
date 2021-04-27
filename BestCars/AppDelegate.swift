//
//  AppDelegate.swift
//  BestCars
//
//  Created by Leonardo Saippa on 19/04/21.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let dataController = DataController(modelName: "BestCars")
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        DataControllerInstance.dataControllerInstance.setDataController(currentData: (UIApplication.shared.delegate as? AppDelegate)?.dataController)
        dataController.load()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveViewContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveViewContext()
    }

    func saveViewContext() {
        try? dataController.viewContext.save()
    }

}

