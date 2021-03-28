//
//  ContentView.swift
//  WizardSchoolSignUpSwiftUI
//
//  Created by Jhonny Bill on 3/28/21.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""

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
                TextField("Wizard name", text: $username)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
