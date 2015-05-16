//
//  TaskModel.swift
//  TaskIt
//
//  Created by Scott Kornblatt on 12/19/14.
//  Copyright (c) 2014 Scott Kornblatt. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
