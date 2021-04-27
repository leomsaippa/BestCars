//
//  FavoriteCars.swift
//  BestCars
//
//  Created by Leonardo Saippa on 26/04/21.
//

import Foundation
import UIKit

class FavoriteCars: NSObject {
    
    static let instance =  FavoriteCars()
    
    var favoriteCars:[Car]?

   private override init(){
    }
    
    func getFavoriteCars() -> [Car]?{
        if(favoriteCars == nil) {
            favoriteCars = [Car]()
        }
        print("get")

        print(favoriteCars)
        return favoriteCars
    }
   
    func setFavoriteCars(cars: [Car]) {
        if(favoriteCars == nil) {
            favoriteCars = [Car]()
        }
        print("set")
        print(favoriteCars)
        self.favoriteCars = cars
    }
    
    
}
