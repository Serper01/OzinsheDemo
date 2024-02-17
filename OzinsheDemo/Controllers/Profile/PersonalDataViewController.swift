//
//  PersonalDataViewController.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 18.01.2024.
//

import UIKit
import Localize_Swift
import Alamofire
import SVProgressHUD
import SwiftyJSON

class PersonalDataViewController: UIViewController,LanguageProtocol {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UINavigationItem!
    
    @IBOutlet weak var saveChangesButton:
    UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var birthdateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureViews()
        saveChangesButton.layer.cornerRadius = 12
 
        
        SVProgressHUD.show()
      
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        AF.request(Urls.RETURNS_USER_PROFILE, method: .get, headers: headers).responseData{ response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data:data,encoding: .utf8)!
                print (resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print ("JSON: \(json)")
                
                self.nameTextField.text = json["name"].stringValue
                self.emailTextField.text = json["user"]["email"].stringValue
                self.numberTextField.text = json["phoneNumber"].stringValue
                self.birthdateTextField.text = json["birthDate"].stringValue
               
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
    
    func configureViews(){
        nameLabel.text = "YOUR_NAME".localized()
        birthdayLabel.text = "BIRTH_DATE".localized()
        phoneLabel.text = "YOUR_PHONE_NUMBER".localized()
        saveChangesButton.setTitle("SAVE_CHANGES".localized(), for: .normal)
        title = "PERSONAL_DATA".localized()
    }
    
    func languageDidChanged() {
        configureViews()
    }
    
    @IBAction func saveData(_ sender: Any) {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let number = numberTextField.text!
        let birthDate = birthdateTextField.text!
        
        SVProgressHUD.show()
        let parameters: [String: Any] = [
            "name": name,
            "email": email,
            "phoneNumber": number,
            "birthDate": birthDate,
          ]

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        AF.request(Urls.UPDATE_USER_PROFILE, method: .put, parameters: parameters,encoding: JSONEncoding.default, headers: headers).responseData{ response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data:data,encoding: .utf8)!
                print (resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print ("JSON: \(json)")
                
                self.navigationController?.popViewController(animated: true)
                
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
        let personalDataVC = self.storyboard?.instantiateViewController(identifier: "ProfileViewController")
        personalDataVC?.modalPresentationStyle = .fullScreen
        self.present(personalDataVC!,animated: true,completion: nil)
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
