//
//  Networking.swift
//  WizardSchoolSignUpUIKit
//
//  Created by Lareen Melo on 1/3/21.
//

import Foundation

typealias ValidateCompletion = (Result<Bool,Error>) -> Void

class Networking {
    
    /// Validates that the user name is available to use
    func validate(userName: String, completionHandler: @escaping ValidateCompletion) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
            let isAvailable = Bool.random()
            
            completionHandler(.success(isAvailable))
        }
    }
}
