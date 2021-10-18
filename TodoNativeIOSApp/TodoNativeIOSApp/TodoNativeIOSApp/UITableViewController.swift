//
//  UITableViewController.swift
//  TodoNativeIOSApp
//
//  Created by Nick Ingels on 11/10/2021.
//  Copyright © 2021 EHB. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchTodoData { (Todos) in
            for todo in Todos {
                print(todo.Todo!)
            }
        }
    }
    
        func fetchTodoData(completionHandler: @escaping ([Todo]) -> Void) {
        let url = URL(string: "https://todo-backend-sprint1.herokuapp.com/Todos")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let TodoData = try JSONDecoder().decode([Todo].self, from: data)
            
                completionHandler(TodoData)
            }
            catch {
                let error = error
                print(error)
            }
            
            
        }.resume()
    }
}
