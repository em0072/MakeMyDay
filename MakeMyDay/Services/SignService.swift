//
//  SignService.swift
//  MakeMyDay
//
//  Created by Митько Евгений on 16.11.17.
//  Copyright © 2017 Evgeny Mitko. All rights reserved.
//

import Foundation
import CloudKit

class SignService {
    
    let remoteDatabase = DatabaseService.shared
    
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
    
    
    func signIn(_ completion: ((_ iCloudId: String)->())? = nil ) {
        iCloudUserIDAsync { (recordId, error) in
            if let userId = recordId?.recordName {
                Log.d("fetched ID \(userId)")
                Defaults[.iCloudRecordId] = userId
                completion?(userId)
            } else if let error = error {
                Log.e(error.localizedDescription)
            } else {
                Log.e("error fetching iCloud Record")
            }
        }
    }
    
    func singInFirebase() {
        remoteDatabase.upadeUserDirectory()
    }
    
    
}
