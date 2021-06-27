//
//  SignupView.swift
//  WizardSchoolSignUpSwiftUI
//
//  Created by Jhonny Bill on 3/28/21.
//

import SwiftUI
import Combine

struct SignupView: View {
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    @ObservedObject private var viewModel = SignupViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                textFields
                createAccountButton
                Spacer()
            }
            .padding()
            .navigationBarTitle("Wizard School Signup", displayMode: .inline)
        }
    }

    private var textFields: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "person.circle")
                    .foregroundColor(viewModel.usernameState.color)
                TextField("Wizard name", text: Binding.init(get: {
                    self.viewModel.username
                }, set: { (username) in
                    self.viewModel.username = username
                }))
            }

            HStack {
                Image(systemName: "lock.circle")
                TextField("Password", text: $password)
            }

            HStack {
                Image(systemName: "lock.circle")
                TextField("Password Confirmation", text: $passwordConfirmation)
            }
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }

    private var createAccountButton: some View {
        Button(action: {}, label: {
            HStack {
                Spacer()
                Text("Create Account")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color.green)
            .cornerRadius(8)
        })
    }
}

private extension SignupViewModel.ValidationState {
    var color: Color {
        switch self {
        case .initial:
            return Color(.label)
        case .valid:
            return Color(.systemGreen)
        case .invalid:
            return Color(.systemRed)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
