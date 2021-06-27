//
//  Networking.swift
//  WizardSchoolSignUpUIKit
//
//  Created by Lareen Melo on 1/3/21.
//

import Foundation

typealias ValidateCompletion = (Result<Bool, Error>) -> Void

class Networking {
    /// Validates that the user name is available to use
    func validate(userName: String, completionHandler: @escaping ValidateCompletion) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
            let isAvailable = !Database.names.contains(userName)
            completionHandler(.success(isAvailable))
        }
    }
}

fileprivate struct Database {
    static let names = [
        "anna",
        "valencia",
        "john",
        "janne",
        "zelo",
        "titus",
        "kimmy",
        "liliam",
        "mike michael"
    ]
}
