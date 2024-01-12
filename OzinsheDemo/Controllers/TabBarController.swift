//
//  TabBarController.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 11.01.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTabImages()
    }
    
    func setTabImages(){
        let homeselectedimage = UIImage(named: "HomeSeleted")!.withRenderingMode(.alwaysOriginal)
        let searchselectedimage = UIImage(named: "SelectedSearch")!.withRenderingMode(.alwaysOriginal)
        let favoriteselectedimage = UIImage(named: "FavoriteSelected")!.withRenderingMode(.alwaysOriginal)
        let profileselectedimage = UIImage(named: "ProfileSelected")!.withRenderingMode(.alwaysOriginal)
        
        
        tabBar.items?[0].selectedImage = homeselectedimage
        tabBar.items?[1].selectedImage = searchselectedimage
        tabBar.items?[2].selectedImage = favoriteselectedimage
        tabBar.items?[3].selectedImage = profileselectedimage
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
