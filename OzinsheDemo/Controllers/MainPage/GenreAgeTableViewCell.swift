//
//  GenreAgeTableViewCell.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 11.02.2024.
//

import UIKit
import SDWebImage
class GenreAgeTableViewCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var mainMovie = MainMovies()
    var delegate : MovieProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(mainMovie: MainMovies) {
        self.mainMovie = mainMovie
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mainMovie.cellType == .ageCategory {
            return mainMovie.categoryAges.count
        }
        return mainMovie.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        // imageview
        let transformer = SDImageResizingTransformer(size: CGSize(width: 184, height: 112), scaleMode: .aspectFill)
        let imageview = cell.viewWithTag(1000) as! UIImageView
        imageview.layer.cornerRadius = 8
        
        let nameLabel = cell.viewWithTag(1001) as! UILabel
        if mainMovie.cellType == .ageCategory {
            imageview.sd_setImage(with: URL(string: mainMovie.categoryAges[indexPath.row].link),placeholderImage: nil,context: [.imageTransformer: transformer])
            nameLabel.text = mainMovie.categoryAges[indexPath.row].name
            titleLabel.text = "Жасына сәйкес"
        } else {
            imageview.sd_setImage(with: URL(string: mainMovie.genres[indexPath.row].link),placeholderImage: nil,context: [.imageTransformer: transformer])
            nameLabel.text = mainMovie.genres[indexPath.row].name
            titleLabel.text = "Жанрды таңдаңыз"
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if mainMovie.cellType == .genre{
                    delegate?.genreDidSelect(genreId: mainMovie.genres[indexPath.row].id, genreName: mainMovie.genres[indexPath.row].name)
                }else{
                    delegate?.ageCategoryDidSelect(categoryAgeId: mainMovie.categoryAges[indexPath.row].id)
                }
    }

}
