//
//  Networking+Combine.swift
//  WizardSchoolSignUpSwiftUI
//
//  Created by Jhonny Bill on 6/27/21.
//

import Foundation
import Combine

extension Networking {
    func validatePublisher(userName: String) -> Deferred<Future<Bool, Error>> {
        Deferred {
            Future { promise in
                self.validate(userName: userName, completionHandler: promise)
            }
        }
    }
}
