//
//  SignService.swift
//  MakeMyDay
//
//  Created by Митько Евгений on 16.11.17.
//  Copyright © 2017 Evgeny Mitko. All rights reserved.
//

import Foundation
import CloudKit

struct SignService {
    
    static var shared: SignService = {
        return SignService()
    }()
    /// async gets iCloud record ID object of logged-in iCloud user
    private func iCloudUserIDAsync(complete: @escaping (_ instance: CKRecordID?, _ error: Error?) -> ()) {
        let container = CKContainer.default()
        container.fetchUserRecordID() {
            recordID, error in
            if error != nil {
                complete(nil, error)
            } else {
                complete(recordID, nil)
            }
        }
    }
    
    
    func signIn() {
        iCloudUserIDAsync { (recordId, error) in
            if let userId = recordId?.recordName {
                print("fetched ID \(userId)")
                Defaults[.iCloudRecordId] = userId
            } else if let error = error {
                print(error.localizedDescription)
            } else {
                print("error fetching iCloud Record")
            }
        }
    }
    
    
}
