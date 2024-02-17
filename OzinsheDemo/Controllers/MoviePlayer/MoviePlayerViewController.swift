//
//  MoviePlayerViewController.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 16.02.2024.
//

import UIKit
import YouTubePlayer

class MoviePlayerViewController: UIViewController {
    
    @IBOutlet weak var player: YouTubePlayerView!
    var video_link = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.loadVideoID(video_link)
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
