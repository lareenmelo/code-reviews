//
//  ValidationState.swift
//  WizardSchoolSignUpSwiftUI
//
//  Created by Melo, Lareen on 4/4/21.
//

import Foundation

extension SignupViewModel {
    /// Defines the states a TextField element can have during sign-up
    enum ValidationState {
        /// not started, neither valid or invalid
        case initial
        /// content is accepted
        case valid
        /// content is not accepted
        case invalid

    }
}
