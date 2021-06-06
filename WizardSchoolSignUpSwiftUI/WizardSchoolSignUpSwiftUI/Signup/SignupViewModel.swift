//
//  SignupViewModel.swift
//  WizardSchoolSignUpSwiftUI
//
//  Created by Melo, Lareen on 4/4/21.
//

import Foundation
import Combine

public class SignupViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var isUsernameValid = ValidationState.initial
    private var cancellables = Set<AnyCancellable>()

    init() {
        $username
            .map { username -> ValidationState in
                if username.isEmpty || username.contains(" ") {
                    return ValidationState.invalid
                } else {
                    return ValidationState.valid
                }
            }
            .assign(to: \.isUsernameValid, on: self)
            .store(in: &cancellables)
    }
}


/*
 private - "network" call
 public - action triggers (button)
 public - validation de los textfields and button
 */
