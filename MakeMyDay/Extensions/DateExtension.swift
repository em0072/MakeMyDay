//
//  DateExtension.swift
//  MakeMyDay
//
//  Created by Митько Евгений on 18.11.17.
//  Copyright © 2017 Evgeny Mitko. All rights reserved.
//

import Foundation


extension Date {
    
    var timeIntervalSince1970InMilliseconds: Double {
        return timeIntervalSince1970 * 1000
    }
}
