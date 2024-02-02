//
//  LogOutViewController.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 26.01.2024.
//

import UIKit
import Localize_Swift

class LogOutViewController: UIViewController,UITableViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var exitLabel: UILabel!
    
    @IBOutlet weak var exitLabel2: UILabel!
    
    @IBOutlet weak var cancelLogOutButton: UIButton!
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
        let tap: UIGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
    
    }
    
    func configureView() {
        backgroundView?.layer.cornerRadius = 32
        backgroundView.clipsToBounds = true
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        logoutButton.layer.cornerRadius = 12.0
        
        exitLabel.text = "EXIT".localized()
        exitLabel2.text = "EXIT_CONFIRMATION".localized()
        logoutButton.setTitle("YES".localized(), for: .normal)
        cancelLogOutButton.setTitle("NO".localized(), for: .normal)
        
    }
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case.changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.backgroundView.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
        case.ended:
            if viewTranslation.y < 100 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, animations: {
                    self.backgroundView.transform = .identity
                })
            } else {
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true,completion: nil)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: backgroundView))! {
            return false
        }
        return true
    }
    
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        
        let rootVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInNavigationController") as! UINavigationController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        appDelegate.window?.makeKeyAndVisible()
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismissView()
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
