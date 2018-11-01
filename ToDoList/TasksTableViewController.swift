//
//  TaskTableViewController.swift
//  AV2Ios
//
//  Created by administrador on 23/10/2018.
//  Copyright © 2018 administrador. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController {
    let section = ["To Do", "Done"]
    var tasksTemp = [Task]()
    
    var taskInSections: Array<Array<Task>> = [[], []]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let task1 : Task?
//        task1 = TaskDB.instance.newTask()
//
//        task1!.name = "Teste"
//        task1!.priority = "B"
//        task1!.status = false
//
//        let task2 : Task?
//        task2 = TaskDB.instance.newTask()
//
//        task2!.name = "Teste2"
//        task2!.priority = "A"
//        task2!.status = true
//
//        TaskDB.instance.saveContext()
        
        self.tasksTemp = TaskDB.instance.allTasks()
        
        self.taskInSections[0] = self.tasksTemp.filter({$0.status==false})
        self.taskInSections[1] = self.tasksTemp.filter({$0.status==true})
        
        print(self.taskInSections[0])
        print(self.taskInSections[1])
        
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.section[section]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var count:Int = 0s
        print(self.taskInSections[section].count)
        return self.taskInSections[section].count
//        if (section == 0) {
//
//            count = tasks.filter({$0.status==false}).count
//
//        }else{
//
//            count = tasks.filter({$0.status==true}).count
//        }
//
//        return count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell

        cell.name.text = self.taskInSections[indexPath.section][indexPath.row].name!
        cell.priority.backgroundColor = self.setPriorityColor(index:self.taskInSections[indexPath.section][indexPath.row].priority!)
        cell.status = self.taskInSections[indexPath.section][indexPath.row].status

        return cell
    }
    
    @IBAction func unwindToTaskList(segue:UIStoryboardSegue) -> Void {
       
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if let svc = segue.source as? TaskViewController {
                self.taskInSections[indexPath.section][indexPath.row] = svc.task!
                self.tableView.reloadData()
                
            }
            
        } else if(segue.identifier == "Save") {
            
            if let svc = segue.source as? TaskViewController {
                if let task = svc.task {
                    if(task.status){
                        self.taskInSections[1].append(task)
                        
                    }
                    else{
                        self.taskInSections[0].append(task)
                    }
                    
                    self.tableView.reloadData()
                }
                
            }
            
        }
        TaskDB.instance.saveContext()
        self.tableView.reloadData()
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
            let toRemove = self.taskInSections[indexPath.section].remove(at: indexPath.row)
            
            TaskDB.instance.delete(task: toRemove)
            TaskDB.instance.saveContext()
            self.tableView.reloadData()
            
            tableView.reloadData()
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
                let task = self.taskInSections[indexPath!.section][indexPath!.row]
                
                dvc.task = task
                self.tableView.reloadData()
                
            }
        }
    }
    
    func setPriorityColor(index:String) -> UIColor {
        var color = UIColor.red
        
        if index == "B" {color = UIColor.green}
        if index == "M" {color = UIColor.orange}
        
        return color
    }
    
    func setPriorityByIndex(letter: String) -> Int {
        if letter == "B" {return 0}
        if letter == "M" {return 1}
        else if letter == "A" {return 2}
        
        return 0
    }
    
}

