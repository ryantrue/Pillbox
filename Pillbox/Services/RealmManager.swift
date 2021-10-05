//
//  RealmManager.swift
//  Pillbox
//
//  Created by Rayen on 9/30/21.
//

import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveAidKitModel(model: AidKitModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteAidKitModel(model: AidKitModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    
    func saveTaskModel(model: TaskModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteTaskModel(model: TaskModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func updateReadyButtonTaskModel(task: TaskModel, bool: Bool) {
        try! localRealm.write {
            task.taskReady = bool
        }
    }
}
