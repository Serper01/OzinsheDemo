//
//  MainBannerTableViewCell.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 11.02.2024.
//

import UIKit

class MainBannerTableViewCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource {
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var mainMovie = MainMovies()
    var delegate : MovieProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = TopAlignedCollectionViewFlowLayout()
               layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
               layout.minimumInteritemSpacing = 16
               layout.minimumLineSpacing = 16
               layout.estimatedItemSize.width = 112
               layout.estimatedItemSize.height = 220
               layout.scrollDirection = .horizontal
               collectionView.collectionViewLayout = layout
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
        return mainMovie.bannerMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCollectionViewCell
        cell.setData(bannerMovie: mainMovie.bannerMovie[indexPath.row])
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.movieDidSelect(movie: mainMovie.bannerMovie[indexPath.row].movie)
    }
}
