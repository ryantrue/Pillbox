//
//  SheduleModel.swift
//  Pillbox
//
//  Created by Rayen on 9/30/21.
//

import RealmSwift
import Foundation

class ScheduleModel: Object {
    
    @Persisted var scheduleDate = Date()
    @Persisted var scheduleTime = Date()
    @Persisted var scheduleName: String = "Unknown"
    @Persisted var scheduleDose: String = "Unknown"
    @Persisted var scheduleUnitOfMeasurment: String = "Unknown"
    @Persisted var schedulePillName: String = "Name Pillname"
    @Persisted var scheduleColor: String = "5DADE2"
    @Persisted var scheduleRepeat: Bool = true
    @Persisted var scheduleWeekday: Int = 1
}
