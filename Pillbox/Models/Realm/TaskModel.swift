//
//  TaskModel.swift
//  Pillbox
//
//  Created by Rayen on 02.10.2021.
//

import RealmSwift
import Foundation

class TaskModel: Object {
    @Persisted var taskDate: Date?
    @Persisted var taskName: String = "Unknown"
    @Persisted var taskNote: String = "Unknown"
    @Persisted var taskColor: String = "1A4766"
    @Persisted var taskReady: Bool = false
}
