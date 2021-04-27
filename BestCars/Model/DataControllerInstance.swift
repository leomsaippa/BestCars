//
//  DataControllerInstance.swift
//  BestCars
//
//  Created by Leonardo Saippa on 26/04/21.
//

import Foundation
import UIKit

class DataControllerInstance: NSObject {
    
    static let dataControllerInstance =  DataControllerInstance()
    
    var dataController:DataController?

   private override init(){
    }
    
    func getDataController() -> DataController? {
        return dataController
    }
    
    func setDataController(currentData: DataController?){
        self.dataController = currentData
    }
    
}
