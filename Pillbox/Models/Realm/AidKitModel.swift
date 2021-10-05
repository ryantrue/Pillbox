//
//  SheduleModel.swift
//  Pillbox
//
//  Created by Rayen on 9/30/21.
//

import Combine
import RealmSwift
import Foundation

final class AidKitModel: Object {
    
    @Persisted var aidKitDate: Date?
    @Persisted var aidKitTime: Date?
    @Persisted var aidKitName: String = ""
    @Persisted var aidKitDose: String = ""
    @Persisted var aidKitUnitOfMeasurment: String = ""
    @Persisted var aidKitPillName: String = "Pill"
    @Persisted var aidKitColor: String = "5DADE2"
    @Persisted var aidKitRepeat: Bool = true
    @Persisted var aidKitWeekday: Int = 1
}
