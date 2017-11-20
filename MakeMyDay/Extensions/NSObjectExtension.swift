//
//  NSObjectExtension.swift
//  MakeMyDay
//
//  Created by Митько Евгений on 16.11.17.
//  Copyright © 2017 Evgeny Mitko. All rights reserved.
//

import Foundation
import IGListKit

extension NSObject: ListDiffable {
    
    // ------------------------------------------------------------------------ //
    //                      MARK: - ListDiffable                                //
    // ------------------------------------------------------------------------ //

    // MARK: - IGListDiffable
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
    
}
