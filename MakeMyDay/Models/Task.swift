//
//  Task.swift
//  MakeMyDay
//
//  Created by Митько Евгений on 18.11.17.
//  Copyright © 2017 Evgeny Mitko. All rights reserved.
//

import Foundation
import IGListKit

class Task: ListDiffable {
    private static let idC = "id"
    private static let titleC = "title"
    
    
    var id: String
    var title: String
    
    static func createNew(withTitle title: String) -> Task {
        let identificator = String("Task\(Date().timeIntervalSince1970InMilliseconds)")
        return Task(id: identificator, title: title)
    }
    
    init(id: String, title: String) {
        self.title = title
        self.id = id
    }
    
    convenience init?(dict: [String: Any]) {
        guard let id = dict[Task.idC] as? String,
            let title = dict[Task.titleC] as? String else { return nil }
        self.init(id: id, title: title)
    }
    
    
    // ------------------------------------------------------------------------ //
    //                           MARK: - List Diffable                          //
    // ------------------------------------------------------------------------ //
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? Task else { return false }
        return title == object.title
    }
    
    // ------------------------------------------------------------------------ //
    //                        MARK: - Firebase Parsing                          //
    // ------------------------------------------------------------------------ //
    var dictionary: [String: Any] {
        return [
            Task.idC : id,
            Task.titleC : title
        ]
    }
}
