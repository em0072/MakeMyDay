//
//  DataBaseService.swift
//  MakeMyDay
//
//  Created by Митько Евгений on 18.11.17.
//  Copyright © 2017 Evgeny Mitko. All rights reserved.
//

import Foundation
import Firebase

protocol DatabaseTaskListner: class {
    func tasksDidUpdate(_ tasks: [Task])
}

class DatabaseService {
    
    weak var taskListner: DatabaseTaskListner? {
        didSet {
            taskListnerReg?.remove()
        }
    }
    var taskListnerReg: ListenerRegistration?
    
    private lazy var dataBase: Firestore = {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        let db = Firestore.firestore()
        db.settings = settings
        return db
    }()
    
    enum Collection {
        case currentUserTasks
        
        func path(_ db: Firestore) -> CollectionReference {
            switch self {
            case .currentUserTasks:
                return db.collection(DBConstant.userTaskPath)
            }
        }
    }
    
    enum Document {
        case currentUser
        
        func path(_ db: Firestore) -> DocumentReference {
            switch self {
            case .currentUser:
                return db.document(DBConstant.currentUserPath)
            }
        }
    }
    
    enum ListnerType {
        case taskListner(taskList: TaskList)
        case taskListsListner
    }
    
    static var shared: DatabaseService = {
        return DatabaseService()
    }()
    
    init() {
            }
    
    func add(_ listner: ViewController, as listnerType: ListnerType) {
        switch listnerType {
        case .taskListner(let taskList):
            guard let properListner = listner as? DatabaseTaskListner else {
                fatalError("\(String(describing: listner)) must conform to DatabaseTaskListner protocol")
            }
            taskListnerReg?.remove()
            taskListner = properListner
            addTaskListner(for: taskList)
        default:
            break
        }
    }
    
//    func addListner(_ listner: DatabaseTaskListner) {
//        taskListner = listner
//        addDatabaseListner()
//    }
    
    func removeListner(listnerType: ListnerType) {
        switch listnerType {
        case .taskListner:
            taskListner = nil
        default:
            break
        }
        
    }
    
    private func addTaskListner(for taskList: TaskList) {
        taskListnerReg = Collection.currentUserTasks.path(dataBase).addSnapshotListener { [weak self] (snapshot, error) in
            guard let selfie = self else { return }
            if let snapshot = snapshot {
                var tasks = [Task]()
                for snapshot in snapshot.documents {
                    if let task = Task(dict: snapshot.data()) {
                        tasks.append(task)
                    }
                }
                selfie.taskListner?.tasksDidUpdate(tasks)
            }
        }
    }
    
    func upadeUserDirectory() {
        Document.currentUser.path(dataBase).setData([
            DBConstant.phoneInfo: "\(UIDevice.current.model) - \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document saved")
            }
        }
    }
    
    func add(_ task: Task) {
        Collection.currentUserTasks.path(dataBase).document(task.id).setData(task.dictionary)
    }
}

struct DBConstant {
    // MARK: - Path
    static let currentUserPath = "Users/\(Defaults[.iCloudRecordId])"
    static let userTaskPath = "\(DBConstant.currentUserPath)/Tasks"
    
    // MARK: - Property names
    static let phoneInfo = "phoneInfo"
    
    
}
