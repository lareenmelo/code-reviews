//
//  ViewController.swift
//  WizardSchoolSignUpUIKit
//
//  Created by Jhonny Bill on 12/13/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var userNameTextField: UITextField!
    @IBOutlet private var userNameIcon: UIImageView!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var passwordIcon: UIImageView!
    @IBOutlet private var passwordConfirmationTextField: UITextField!
    @IBOutlet private var passwordConfirmationIcon: UIImageView!
    @IBOutlet private var createAccountButton: UIButton!
    
    private var userName = ""
    private var password = ""
    
    private var network = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    private func textDidChange(_ notification: Notification) -> Void {
        guard
            notification.object as? NSObject == userNameTextField,
            let userName = userNameTextField.text
        else { return }
        validate(userName: userName.lowercased())
    }

    private func validate(userName: String) {
         network.validate(userName: userName) { result in
             switch result {
             case .success(let isAvailable):
                 DispatchQueue.main.async { [weak self] in
                     self?.userNameIcon?.tintColor = isAvailable ? .systemGreen : .systemRed
                 }
             case .failure:
                 break
             }
         }
     }
}
