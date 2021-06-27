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
    @Published private(set) var passwordConfirmationState = ValidationState.initial
    @Published private(set) var isCreateAccountButtonDisabled = true

    private let network = Networking()
    private var cancellables = Set<AnyCancellable>()

    init() {

        let username = $username
            .dropFirst()

        let isUsernameValid = username
            .map { !$0.isEmpty && !$0.contains(" ") }

        isUsernameValid
            .combineLatest(username)
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

        let password = $password
            .dropFirst()

        password
            .map { password -> ValidationState in
                let isValid = password.count > 8
                return isValid ? .valid : .invalid
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.passwordState, on: self)
            .store(in: &cancellables)

        Publishers.CombineLatest(password, $passwordConfirmation.dropFirst())
            .map { password, passwordConfirmation -> ValidationState in
                let isValid = password == passwordConfirmation
                return isValid ? .valid : .invalid
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.passwordConfirmationState, on: self)
            .store(in: &cancellables)

        Publishers.CombineLatest3($usernameState, $passwordState, $passwordConfirmationState)
            .map { usernameState, passwordState, passwordConfirmationState -> Bool in
                return usernameState == ValidationState.valid
                    && passwordState == ValidationState.valid
                    && passwordConfirmationState == ValidationState.valid
            }
            .map { !$0 }
            .receive(on: DispatchQueue.main)
            .assign(to: \.isCreateAccountButtonDisabled, on: self)
            .store(in: &cancellables)
    }
}
