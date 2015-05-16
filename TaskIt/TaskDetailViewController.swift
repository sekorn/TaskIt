//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Scott Kornblatt on 11/29/14.
//  Copyright (c) 2014 Scott Kornblatt. All rights reserved.
//

import UIKit

@objc protocol TaskDetailViewControllerDelegate {
  optional func taskDetailEdited()
}

class TaskDetailViewController: UIViewController {
  
  var detailTaskModel: TaskModel!
  
  @IBOutlet weak var subtaskTextField: UITextField!
  @IBOutlet weak var taskTextField: UITextField!
  @IBOutlet weak var duedatePicker: UIDatePicker!
  
  var delegate:TaskDetailViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
    
    // Do any additional setup after loading the view.
    taskTextField.text = detailTaskModel.task
    subtaskTextField.text = detailTaskModel.subtask
    duedatePicker.date = detailTaskModel.date
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
    
    let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    
    detailTaskModel.task = taskTextField.text
    detailTaskModel.subtask = subtaskTextField.text
    detailTaskModel.date = duedatePicker.date
    detailTaskModel.completed = detailTaskModel.completed
    
    appDelegate.saveContext()
    
    self.navigationController?.popViewControllerAnimated(true)
    delegate?.taskDetailEdited!()
  }
}
