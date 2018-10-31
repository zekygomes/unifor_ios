//
//  TaskTableViewController.swift
//  AV2Ios
//
//  Created by administrador on 23/10/2018.
//  Copyright © 2018 administrador. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController {
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let task1 : Task?
        task1 = TaskDB.instance.newTask()
        
        task1!.name = "Teste"
        task1!.priority = "B"
        task1!.status = false
        
        print("ddd")
        
        TaskDB.instance.saveContext()
        
        self.tasks = TaskDB.instance.allTasks()
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        
        cell.name.text = self.tasks[indexPath.row].name!
        cell.priority.backgroundColor = self.setPriorityColor(index:self.tasks[indexPath.row].priority!)
        cell.status = self.tasks[indexPath.row].status
        
        return cell
    }
    
    @IBAction func unwindToTaskList(segue:UIStoryboardSegue) -> Void {
       
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if let svc = segue.source as? TaskViewController {
                self.tasks[indexPath.row] = svc.task!
                self.tableView.reloadData()
                
                TaskDB.instance.saveContext()
            }
            print("bbb")
        } else if(segue.identifier == "Save") {
            print("aaaa")
            if let svc = segue.source as? TaskViewController {
                if let task = svc.task {
                    self.tasks.append(task)
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let toRemove = self.tasks.remove(at: indexPath.row)
            
            TaskDB.instance.delete(task: toRemove)
            TaskDB.instance.saveContext()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "Edit") {
            
            if let dvc = segue.destination as? TaskViewController {
                let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
                let task = self.tasks[indexPath!.row]
                
                dvc.task = task
                
                
            }
        }
    }
    
    func setPriorityColor(index:String) -> UIColor {
        var color = UIColor.cyan
        
        if index == "B" {color = UIColor.black}
        if index == "M" {color = UIColor.blue}
        
        return color
    }
    
    func setPriorityByIndex(letter: String) -> Int {
        if letter == "B" {return 0}
        if letter == "M" {return 1}
        else if letter == "A" {return 2}
        
        return 0
    }
    
}

