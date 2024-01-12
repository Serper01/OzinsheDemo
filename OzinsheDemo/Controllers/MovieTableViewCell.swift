//
//  MovieTableViewCell.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 12.01.2024.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var playView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        posterImageView.layer.cornerRadius = 8
        playView.layer.cornerRadius = 8
        // Configure the view for the selected state
    }
    func setData(movie: String){
        posterImageView.image = UIImage(named: movie)
    }
}
