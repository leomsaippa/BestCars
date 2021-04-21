//
//  MockyCall.swift
//  BestCars
//
//  Created by Leonardo Saippa on 19/04/21.
//


import Foundation
import UIKit

class MockyCall {
    
    enum Endpoints {
        static let base = "https://607e059602a23c0017e8ace6.mockapi.io/fipeCar/"
        static let radius = 20
        
        case getCars
        
        var urlString: String {
            switch self {
                 case .getCars:
                   return Endpoints.base + "cars"
            }
            
        }
        
         var url: URL {
               return URL(string: urlString)!
           }
    }
    
    class func getCars(totalPageAmount:  Int = 0, completion: @escaping ([Car], Int, Error?) -> Void) -> Void {
        
           
        let url = Endpoints.getCars.url
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       
        print(request.cURL(pretty: true))

        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion([], 0, error)
                }
                
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode([Car].self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject,0, nil)
                }
                
            } catch {
                    print(error)

                    DispatchQueue.main.async {
                        completion([], 0, error)
                    }
                
            }
         }
        
        task.resume()
        
        
        
//        let _ = RequestHelper.taskForGETRequest(url: url, responseType: CarResponse.self) { response, error in
//               if let response = response {
//                print("response \(response)")
//                } else {
//                print("error")
//
//                   completion([], 0, error)
//               }
//           }
       }
    
    class func downloadImage(img: String, completion: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: img)
        
        guard let imageURL = url else {
             DispatchQueue.main.async {
                 completion(nil, nil)
             }
             return
         }
         
         let request = URLRequest(url: imageURL)
         let task = URLSession.shared.dataTask(with: request) { data, response, error in
             DispatchQueue.main.async {
                 completion(data, nil)
             }
         }
         task.resume()
    }
    
    
}
    
