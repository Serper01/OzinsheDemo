//
//  ProfileViewController.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 16.01.2024.
//

import UIKit
import Localize_Swift

class  ProfileViewController: UIViewController,UITableViewDelegate,LanguageProtocol {

    @IBOutlet weak var myProfileLabel: UILabel!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var personalDataLabel: UILabel!
    @IBOutlet weak var personalDataButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var termsAndConditionsButton: UIButton!
    @IBOutlet weak var notificationsButton: UIButton!
    @IBOutlet weak var darkModeButton: UIButton!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var `switch`: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let email = UserDefaults.standard.string(forKey: "email"){
        emailLabel.text = email
    }
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       configureViews()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = ""
    }
    
    func configureViews(){
        myProfileLabel.text = "MY_PROFILE".localized()
        languageButton.setTitle("LANGUAGE".localized(), for: .normal)
        personalDataLabel.text = "CHANGE".localized()
        personalDataButton.setTitle("PERSONAL_DATA".localized(), for: .normal)
        changePasswordButton.setTitle("CHANGE_PASSWORD".localized(), for: .normal)
        termsAndConditionsButton.setTitle("TERMS_AND_CONDITIONS".localized(), for: .normal)
        notificationsButton.setTitle("NOTIFICATIONS".localized(), for: .normal)
        darkModeButton.setTitle("DARK_MODE".localized(), for: .normal)
        
        if Localize.currentLanguage() == "ru" {
            languageLabel.text = "Русский"
        }
        
        if Localize.currentLanguage() == "kk" {
            languageLabel.text = "Қазақша"
        }
        if Localize.currentLanguage() == "en" {
            languageLabel.text = "English"
        }
    }
    
    @IBAction func languageShow(_ sender: Any) {
        
        let languageVC = storyboard?.instantiateViewController(identifier: "LanguageViewController") as! LanguageViewController
        languageVC.modalPresentationStyle = .overFullScreen
        languageVC.delegate = self
        present(languageVC, animated: true, completion: nil)
        
    }
    func languageDidChanged() {
        configureViews()
    }
    
    @IBAction func personalDataButton(_ sender: Any) {
        
        let dataButton = storyboard?.instantiateViewController(identifier: "PersonalDataViewController") as! PersonalDataViewController
        
        navigationController?.show(dataButton, sender: self)
        
    }
    
    @IBAction func logout(_ sender: Any) {
        let logOut = storyboard?.instantiateViewController(identifier: "LogOutViewController") as! LogOutViewController
            logOut.modalPresentationStyle = .overFullScreen
            present(logOut, animated: true, completion: nil)
    }
    
    @IBAction func changePasswordButton(_ sender: Any) {
       
        let dataButton = storyboard?.instantiateViewController(identifier: "PasswordViewController") as! PasswordViewController
        
        navigationController?.show(dataButton, sender: self)
    }
    
    @IBAction func switchTheme(sender: UISwitch) {
        if let window = view.window {
            window.overrideUserInterfaceStyle = sender.isOn ? .dark: .light
        }
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
