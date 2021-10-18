//
//  ViewController.swift
//  TodoNativeIOSApp
//
//  Created by Nick Ingels on 05/10/2021.
//  Copyright © 2021 EHB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
var CurrentTodoLijst = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchTodoData { (Todos) in
            for todo in Todos {
                print(todo.Todo!)
                self.CurrentTodoLijst.append(todo.Todo!)
            }
            DispatchQueue.main.async {
               self.performSegue(withIdentifier: "TodoData", sender: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! TableViewController
        vc.TodoLijst = self.CurrentTodoLijst
    }
}
