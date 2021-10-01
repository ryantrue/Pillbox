//
//  RealmManager.swift
//  Pillbox
//
//  Created by Rayen on 9/30/21.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveSheduleModel(model: ScheduleModel) {
       
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteSheduleModel(model: ScheduleModel) {
       
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
}
