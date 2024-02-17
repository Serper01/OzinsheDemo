//
//  PasswordViewController.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 19.01.2024.
//

import UIKit
import Localize_Swift

class PasswordViewController: UIViewController {
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: TextFieldWithPadding!
    
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    
    @IBOutlet weak var repeatPasswordTextField: TextFieldWithPadding!
    
    @IBOutlet weak var saveChangesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureViews()
        hideKeyboardWhenTappedAround()
    }
    
    func configureViews() {
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.borderWidth = 1
//        passwordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        passwordTextField.layer.borderColor = UIColor(named: "#E5EBF0 - #374151")?.cgColor
        
        repeatPasswordTextField.layer.cornerRadius = 12
        repeatPasswordTextField.layer.borderWidth = 1
//        repeatPasswordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        repeatPasswordTextField.layer.borderColor = UIColor(named: "#E5EBF0 - #374151")?.cgColor
        
        saveChangesButton.layer.cornerRadius = 12
        
        passwordLabel.text = "PASSWORD".localized()
        repeatPasswordLabel.text = "REPEAT_PASSWORD".localized()
        saveChangesButton.setTitle("SAVE_CHANGES".localized(), for: .normal)
        title = "CHANGE_PASSWORD".localized()
        
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func passwordTextFieldEditingDidBegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
        
    }
    @IBAction func textFieldEditingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.90, green: 0.92 , blue: 0.94, alpha: 1.00).cgColor
    }
    
}
