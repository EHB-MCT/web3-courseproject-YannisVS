//
//  TableViewController.swift
//  TodoNativeIOSApp
//
//  Created by Nick Ingels on 11/10/2021.
//  Copyright © 2021 EHB. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  var TodoLijst = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
  
    // MARK: - Table view data source

    //override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
       //return 0
    //}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return TodoLijst.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = TodoLijst[indexPath.row]

        // Configure the cell...
        return cell
    }
    
    @IBAction func TodoAdd(_ sender: Any) {
        let alertController = UIAlertController(title: "New Todo", message: "New todo", preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "Your Todo"
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: {

            action in guard let text = alertController.textFields?.first?.text else { print("Not text available"); return}

            let todo = Todo(todo: text)

            let postRequest = PostRequest()
            postRequest.save(todo, completion: {result in
                switch result {
                case .success(let todo):
                    print("Todo has been added")
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Something went wrong: (error)")
                }
            })

        }))

        self.present(alertController, animated: true)
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
