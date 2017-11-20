//
//  TaskList.swift
//  MakeMyDay
//
//  Created by Митько Евгений on 19.11.17.
//  Copyright © 2017 Evgeny Mitko. All rights reserved.
//

import Foundation
import IGListKit


class TaskList: ListDiffable {
    private static let idC = "id"
    private static let titleC = "title"
    private static let tasksC = "tasks"
    
    var id: String
    var title: String
    var tasks: [Task]
    
    init(id: String, title: String, tasks: [Task]) {
        self.id = id
        self.title = title
        self.tasks = tasks
    }
    
    convenience init?(dict: [String: Any]) {
        guard let id = dict[TaskList.idC] as? String,
            let title = dict[TaskList.titleC] as? String else { return nil }
        self.init(id: id, title: title, tasks: [])
    }

    static func createNew(withTitle title: String) -> TaskList {
        let identificator = String("List\(Date().timeIntervalSince1970InMilliseconds)")
        return TaskList(id: identificator, title: title, tasks: [])
    }
    
    
    // ------------------------------------------------------------------------ //
    //                           MARK: - List Diffable                          //
    // ------------------------------------------------------------------------ //
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? TaskList else { return false }
        return title == object.title
    }
    
    // ------------------------------------------------------------------------ //
    //                        MARK: - Firebase Parsing                          //
    // ------------------------------------------------------------------------ //

}
