//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Scott Kornblatt on 12/4/14.
//  Copyright (c) 2014 Scott Kornblatt. All rights reserved.
//

import UIKit
import CoreData

protocol AddTaskViewControllerDelegate {
  func addTask(message: String)
  func addTaskCanceled(message: String)
}

class AddTaskViewController: UIViewController {
  
  @IBOutlet weak var taskTextField: UITextField!
  @IBOutlet weak var descriptionTextField: UITextField!
  @IBOutlet weak var dueDatePicker: UIDatePicker!
  
  var delegate:AddTaskViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func cancelButtonTapped(sender: UIButton) {
    self.dismissViewControllerAnimated(true, completion: nil)
    delegate?.addTaskCanceled("Task was not added!")
  }
  
  @IBAction func addTaskButtonTapped(sender: AnyObject) {
    
    // create a reference the to AppDelegate
    let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    
    let managedObjectContext = appDelegate.managedObjectContext
    
    let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
    
    let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
    
    if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
      task.task = taskTextField.text.capitalizedString
    } else {
      task.task = taskTextField.text
    }
    
    if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewToDoKey) {
      task.completed = true
    } else {
      task.completed = false
    }
    
    task.subtask = descriptionTextField.text
    task.date = dueDatePicker.date
    
    
    appDelegate.saveContext()
    
    var request = NSFetchRequest(entityName: "TaskModel")
    var error:NSError? = nil
    
    var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
    
    for res in results {
      println(res)
    }
    
    delegate?.addTask("Task Added")
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
