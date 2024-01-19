//
//  PersonalDataViewController.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 18.01.2024.
//

import UIKit
import Localize_Swift

class PersonalDataViewController: UIViewController,LanguageProtocol {
    
    

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UINavigationItem!
    
    @IBOutlet weak var saveChangesButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureViews()
        saveChangesButton.layer.cornerRadius = 12
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
