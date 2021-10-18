//
//  PostRequest.swift
//  TodoNativeIOSApp
//
//  Created by Nick Ingels on 18/10/2021.
//  Copyright © 2021 EHB. All rights reserved.
//

import Foundation
enum APIError:Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct PostRequest {
    
    let resourceURL: URL
    init() {
        let resourceString = "https://todo-backend-sprint1.herokuapp.com/TodoYannis"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func save (_ todoToSave:Todo, completion: @escaping(Result<Todo, APIError>) -> Void) {
        
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(todoToSave)
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data,
                    let response = response as? HTTPURLResponse,
                    error == nil else {
                        // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
                }

                guard (200 ... 299) ~= response.statusCode else {
                    // check for http errors
                    print("statusCode should be 2xx, but is \(response.statusCode)")
                    print("response = \(response)")
                    return
                }

                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString)")
                
           
            }

            task.resume()
            
        }catch{
            completion(.failure(.encodingProblem))
        }
        
    }
}
