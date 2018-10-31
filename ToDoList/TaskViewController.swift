//
//  TaskViewController.swift
//  AV2Ios
//
//  Created by administrador on 23/10/2018.
//  Copyright © 2018 administrador. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var priority: UISegmentedControl!
    @IBOutlet weak var status: UISwitch!
    
    var task:Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let task = self.task {
            
            self.name.text = task.name
            self.priority.selectedSegmentIndex = self.setPriorityByIndex(letter: task.priority!)
            self.status.isOn = Bool(task.status)
        }
        // Do any additional setup after loading the view.
    }
    
    func setPriorityByIndex(letter: String) -> Int {
        if letter == "B" {return 0}
        if letter == "M" {return 1}
        else if letter == "A" {return 2}
        
        return 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Save" {
            if self.task == nil {
                self.task = TaskDB.instance.newTask()
            }
            
            self.task?.name = self.name.text
            self.task?.priority = setPriorityColor(index:self.priority.selectedSegmentIndex)
            self.task?.status = self.status.isOn
        }
     
    }
    
    
    func setPriorityColor(index:Int) -> String {
        if index == 0 {return "B"}
        if index == 1 {return "M"}
        
        return "A"
    }

}
