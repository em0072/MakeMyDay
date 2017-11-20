//
//  LogService.swift
//  MakeMyDay
//
//  Created by Митько Евгений on 16.11.17.
//  Copyright © 2017 Evgeny Mitko. All rights reserved.
//

import Foundation
import SwiftyBeaver


class Log {
    
    private static var service: Log = {
        let logger = Log()
        logger.setupConsole()
        return logger
    }()
    
    private let logger = SwiftyBeaver.self
    
    private func setupConsole() {
        let console = ConsoleDestination()
        logger.addDestination(console)
    }
    
    static func d(_ message: Any) {
        Log.service.logger.debug(message)
    }
    
    static func e(_ message: Any) {
        Log.service.logger.error(message)
    }
    
}
