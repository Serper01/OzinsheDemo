//
//  RegistrationViewController.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 29.01.2024.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import Localize_Swift

class RegistrationViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: TextFieldWithPadding!
    
    @IBOutlet weak var passwordTextField: TextFieldWithPadding!
    
    @IBOutlet weak var repeatPasswordTextField: TextFieldWithPadding!
    
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var registrationLabel: UILabel!
    
    @IBOutlet weak var registrationLabel2: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var showPasswordButton: UIButton!
    
    @IBOutlet weak var showPasswordButton2: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        hideKeyboardWhenTappedAround()
    }
   
    func configureViews() {
        emailTextField.layer.cornerRadius = 12
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        repeatPasswordTextField.layer.cornerRadius = 12
        repeatPasswordTextField.layer.borderWidth = 1
        repeatPasswordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        registrationButton.layer.cornerRadius = 12
        registrationButton.setTitle("CREATE_ACCOUNT_BUTTON".localized(), for: .normal)
        registrationLabel.text = "CREATE_ACCOUNT_BUTTON".localized()
        registrationLabel2.text = "FILL_IN_DETAILS".localized()
        passwordLabel.text = "PASSWORD".localized()
        repeatPasswordLabel.text = "REPEAT_PASSWORD".localized()
        signInLabel.text = "YOU_ALREADY_HAVE_ACCOUNT".localized()
        signInButton.setTitle("ENTER".localized(), for: .normal)
        
        
        
      
        
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    @IBAction func textFieldEditingDidBegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: TextFieldWithPadding) {
    
        sender.layer.borderColor = UIColor(red: 0.90, green: 0.92 , blue: 0.94, alpha: 1.00).cgColor
    }
    
    
    
   
    
    
    @IBAction func showPassword(_ sender: Any) {
        
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @IBAction func showPassword2(_ sender: Any) {
        repeatPasswordTextField.isSecureTextEntry = !repeatPasswordTextField.isSecureTextEntry
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        SVProgressHUD.show()
        let parameters = ["email": email,"password": password]
        AF.request(Urls.SIGN_UP_URL, method: .post, parameters: parameters,encoding: JSONEncoding.default).responseData{ response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data:data,encoding: .utf8)!
                print (resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print ("JSON: \(json)")
                
                if let token = json["accessToken"].string {
                    Storage.sharedInstance.accessToken = token
                    UserDefaults.standard.set(token,forKey: "accessToken")
                    self.startApp()
                }
                else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response .response?.statusCode {
                    ErrorString = ErrorString + "\(sCode)"
                }
                ErrorString = ErrorString + "\(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
            
        }
        
    }
    func startApp() {
        let tabViewController = self.storyboard?.instantiateViewController(identifier: "TabBarViewController")
        tabViewController?.modalPresentationStyle = .fullScreen
        self.present(tabViewController!,animated: true,completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
