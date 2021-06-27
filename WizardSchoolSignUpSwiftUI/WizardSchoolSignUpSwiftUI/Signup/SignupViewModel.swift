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
    @Published private(set) var usernameState = ValidationState.initial
    @Published private(set) var passwordState = ValidationState.initial

    private let network = Networking()
    private var cancellables = Set<AnyCancellable>()

    init() {
        let isUsernameValid = $username
            .dropFirst()
            .map { !$0.isEmpty && !$0.contains(" ") }

        isUsernameValid
            .combineLatest($username)
            .removeDuplicates(by: { $0.1 == $1.1 })
            .flatMap { [weak self] isUsernameValid, username -> AnyPublisher<ValidationState, Never> in
                guard let self = self, isUsernameValid else { return Just(.invalid).eraseToAnyPublisher() }
                return self.network.validatePublisher(userName: username)
                    .replaceError(with: false)
                    .map { $0 ? ValidationState.valid : ValidationState.invalid }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.usernameState, on: self)
            .store(in: &cancellables)

        $password
            .dropFirst()
            .map { password -> ValidationState in
                let isValid = password.count > 8
                return isValid ? .valid : .invalid
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.passwordState, on: self)
            .store(in: &cancellables)
    }
}

/*
 private - "network" call
 public - action triggers (button)
 public - validation de los textfields and button
 */
