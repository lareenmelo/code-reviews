//
//  ViewController.swift
//  WizardSchoolSignUpUIKit
//
//  Created by Jhonny Bill on 12/13/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var userNameStackView: UIStackView!
    @IBOutlet private var userNameTextField: UITextField!
    @IBOutlet private var userNameIcon: UIImageView!
    @IBOutlet private var passwordStackView: UIStackView!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var passwordIcon: UIImageView!
    @IBOutlet private var passwordConfirmationStackView: UIStackView!
    @IBOutlet private var passwordConfirmationTextField: UITextField!
    @IBOutlet private var passwordConfirmationIcon: UIImageView!
    @IBOutlet private var createAccountButton: UIButton!
    
    private var userName = ""
    private var password = ""
    private var isUserNameValid: Bool = false
    private var isPasswordValid: Bool = false
    private var isPasswordConfirmationValid: Bool = false

    private var network = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureCreateUserButton()

        NotificationCenter.default.addObserver(
            forName: UITextField.textDidChangeNotification,
            object: nil,
            queue: .main,
            using: textDidChange
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UITextField.textDidChangeNotification,
            object: nil
        )
    }

    private func configureView() {
        title = "Wizard School Sign Up"

        let iconConfiguration = UIImage.SymbolConfiguration(textStyle: .body)
        userNameIcon.preferredSymbolConfiguration = iconConfiguration
        passwordIcon.preferredSymbolConfiguration = iconConfiguration
        passwordConfirmationIcon.preferredSymbolConfiguration = iconConfiguration

        createAccountButton.titleLabel?.adjustsFontForContentSizeCategory = true
        configureStackViews()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        createAccountButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        configureStackViews()
    }

    private func configureStackViews() {
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        userNameStackView.axis = isAccessibilityCategory ? .vertical : .horizontal
        passwordStackView.axis = isAccessibilityCategory ? .vertical : .horizontal
        passwordConfirmationStackView.axis = isAccessibilityCategory ? .vertical : .horizontal

        userNameStackView.alignment = isAccessibilityCategory ? .leading : .fill
        passwordStackView.alignment = isAccessibilityCategory ? .leading : .fill
        passwordConfirmationStackView.alignment = isAccessibilityCategory ? .leading : .fill
    }

    private func textDidChange(_ notification: Notification) -> Void {
        guard let notificationObject = notification.object as? NSObject else { return }
        if notificationObject == userNameTextField, let userName = userNameTextField.text {
            validate(userName: userName.lowercased())
        } else if notificationObject == passwordTextField, let password = passwordTextField.text {
            validate(password: password)
            configureCreateUserButton()

        } else if notificationObject == passwordConfirmationTextField, let passwordConfirmation = passwordConfirmationTextField.text {
            validate(password: passwordConfirmation, with: passwordTextField.text)
            configureCreateUserButton()

        }
    }

    private func validate(password: String) {
        let isValidPassword = password.count > 8
        passwordIcon.tintColor = isValidPassword ? .systemGreen : .systemRed
        isPasswordValid = isValidPassword
    }

    private func validate(password: String, with userPassword: String?) {
        let isValidPassword = password == userPassword
        passwordConfirmationIcon.tintColor = isValidPassword ? .systemGreen : .systemRed
        isPasswordConfirmationValid = isValidPassword
    }

    private func validate(userName: String) {
        network.validate(userName: userName) { result in
            switch result {
            case .success(let isAvailable):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.userName = userName
                    self.userNameIcon.tintColor = isAvailable ? .systemGreen : .systemRed
                    self.isUserNameValid = isAvailable
                    self.configureCreateUserButton()

                }
            case .failure:
                break
            }
        }
    }
    
    private func configureCreateUserButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let shouldEnableButton = self.isUserNameValid && self.isPasswordValid && self.isPasswordConfirmationValid
            self.createAccountButton.backgroundColor = shouldEnableButton ? UIColor.systemGreen : UIColor.systemGreen.withAlphaComponent(0.5)
            self.createAccountButton.isEnabled = shouldEnableButton
        }
    }
}
