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
        // Do any additional setup after loading the view.
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmationTextField.delegate = self

    }
    
    
}

// MARK: - Text Field Delegate
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == userNameTextField, let userName = userNameTextField.text {
            
            network.validate(userName: userName) { (result) in
                switch result {
                
                case .success(let isAvailable):
                    DispatchQueue.main.async { [weak self] in
                        if isAvailable {
                            self?.userNameIcon.tintColor = UIColor.green
                        } else {
                            self?.userNameIcon.tintColor = UIColor.red
                        }
                    }
                case .failure(_):
                    break
                }
            }
        }
        
        
        
//        print(textField == userNameTextField)
        return true
    }
    
    /*
     textfield end editing? y
     find out which textfield is currently selected or active
     save the textfield info accordingly
     */
}
