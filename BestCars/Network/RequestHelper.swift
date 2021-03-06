//
//  RequestHelper.swift
//  BestCars
//
//  Created by Leonardo Saippa on 19/04/21.
//


import Foundation

class RequestHelper {

    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type,
                                                          completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       
        print(request.cURL(pretty: true))

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
                
            } catch {
                    print(error)

                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                
            }
         }
        
        task.resume()
        
        return task
    }
    
    class func taskForGETRequestUdacity<ResponseType: Decodable>(url: URL,isStudentCall: Bool, responseType: ResponseType.Type ,completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       
        print(request.cURL(pretty: true))
        let task = URLSession.shared.dataTask(with: url) { data, response, error  in
            if error != nil {
                completion(nil, error)
            }
            guard var data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            do {
                if(!isStudentCall){
                    let range = 5..<data.count
                    data = data.subdata(in: range)
                }
                    let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    
    class func taskForPOSTRequest<ResponseType: Decodable>(url: URL, isStudentCall: Bool, responseType: ResponseType.Type, body: String, httpMethod: String, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        if httpMethod == "POST" {
            request.httpMethod = "POST"
        } else {
            request.httpMethod = "PUT"
        }
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = body.data(using: String.Encoding.utf8)
        print(request.cURL(pretty: true))

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil, error)
            }
            guard var data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            do {
                if(!isStudentCall) {
                    let range = 5..<data.count
                    data = data.subdata(in: range)
                }
                let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
               
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    

}

//Extension to print curl Request
extension URLRequest {
    public func cURL(pretty: Bool = false) -> String {
        let newLine = pretty ? "\\\n" : ""
        let method = (pretty ? "--request " : "-X ") + "\(self.httpMethod ?? "GET") \(newLine)"
        let url: String = (pretty ? "--url " : "") + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"
        
        var cURL = "curl "
        var header = ""
        var data: String = ""
        
        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key,value) in httpHeaders {
                header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
            }
        }
        
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8),  !bodyString.isEmpty {
            data = "--data '\(bodyString)'"
        }
        
        cURL += method + url + header + data
        
        return cURL
    }
}
