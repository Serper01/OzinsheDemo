//
//  MovieInfoViewController.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 15.02.2024.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON
import SVProgressHUD
import YouTubePlayer
import Localize_Swift

class MovieInfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var fullDescriptionButton: UIButton!
    @IBOutlet weak var descriptionGradientView: GradientView!
    @IBOutlet weak var seasonsLabel: UILabel!
    @IBOutlet weak var seasonsButton: UIButton!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var screenShotCollectionView: UICollectionView!
    @IBOutlet weak var addToFavoriteLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var directorNameLabel: UILabel!
    
    @IBOutlet weak var screenShotLabel: UILabel!
    
    
    var movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    setData()
    configureViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func configureViews() {
        backgroundView.layer.cornerRadius = 32
        backgroundView.clipsToBounds = true
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        descriptionLabel.numberOfLines = 4
        
        //ScreenShots
        screenShotCollectionView.dataSource = self
        screenShotCollectionView.delegate = self
        
        if movie.movieType == "MOVIE" {
            seasonsLabel.isHidden = true
            seasonsButton.isHidden = true
            arrowImageView.isHidden = true
        } else {
            seasonsButton.setTitle("\(movie.seasonCount) сезон, \(movie.seriesCount) серия ", for: .normal)
        }
        
        if descriptionLabel.maxNumberOfLines < 5 {
            fullDescriptionButton.isHidden = true
        }
        if movie.favorite {
            favoriteButton.setImage(UIImage(named: "AddFavoriteButton"), for: .normal)
        } else {
//            favoriteButton.setImage(UIImage(named: "FavoriteButton2"), for: .normal)
            favoriteButton.setImage(.favoriteButton2, for: .normal)
        }
        
        
        addToFavoriteLabel.text = "ADD_TO_FAVORITE".localized()
        shareLabel.text = "SHARE".localized()
        directorLabel.text = "DIRECTOR".localized()
        producerLabel.text = "PRODUCER".localized()
        fullDescriptionButton.setTitle("READ_MORE".localized(), for: .normal)
        seasonsLabel.text = "DEPARTMENTS".localized()
        screenShotLabel.text = "SCREENSHOT".localized()
    }
    
    func setData() {
        posterImageView.sd_setImage(with: URL(string: movie.poster_link ))
        nameLabel.text = movie.name
        detailLabel.text = "\(movie.year)"
        descriptionLabel.text = movie.description
        directorLabel.text = movie.director
        producerLabel.text = movie.producer
        
        for item in movie.genres {
            detailLabel.text = detailLabel.text! + " • " + item.name
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playMovie(_ sender: Any) {
        if movie.movieType == "MOVIE" {
            let playerVC = storyboard?.instantiateViewController(withIdentifier: "MoviePlayerViewController") as! MoviePlayerViewController
            
            playerVC.video_link = movie.video_link
            
            navigationController?.show(playerVC, sender: self)
        } else {
            let seasonsVC = storyboard?.instantiateViewController(withIdentifier: "SeasonsSeriesViewController") as! SeasonsSeriesViewController
            seasonsVC.movie = movie
            navigationController?.show(seasonsVC, sender: self)
        }
    }
    
    @IBAction func openAllSeasonsButton(_ sender: Any) {
        if movie.movieType == "MOVIE" {
            let playerVC = storyboard?.instantiateViewController(withIdentifier: "MoviePlayerViewController") as! MoviePlayerViewController
            
            playerVC.video_link = movie.video_link
            
            navigationController?.show(playerVC, sender: self)
        } else {
            let seasonsVC = storyboard?.instantiateViewController(withIdentifier: "SeasonsSeriesViewController") as! SeasonsSeriesViewController
            seasonsVC.movie = movie
            navigationController?.show(seasonsVC, sender: self)
        }
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        var method = HTTPMethod.post
        if movie.favorite {
            method = .delete
        }
        SVProgressHUD.show()
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        let parameters = ["movieId": movie.id] as [String: Any]
        AF.request(Urls.FAVORITE_URL, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData {
            response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print (resultString)
            }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                self.movie.favorite.toggle()
                self.configureViews()
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + "\(sCode)"
                }
                ErrorString = ErrorString + "\(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
    @IBAction func shareMovie(_ sender: Any) {
        let text = "\(movie.name) \n\(movie.description)"
        let image = posterImageView.image
        let shareAll = [text,image!] as! [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController,animated: true, completion: nil)
    }
    
    @IBAction func fullDescription(_ sender: Any) {
        if descriptionLabel.numberOfLines > 4 {
            descriptionLabel.numberOfLines = 4
            fullDescriptionButton.setTitle("READ_MORE".localized(), for: .normal)
            descriptionGradientView.isHidden = false
        } else {
            descriptionLabel.numberOfLines = 30
            fullDescriptionButton.setTitle("HIDE".localized(), for: .normal)
            descriptionGradientView.isHidden = true
        }
    }
    
    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let transformer = SDImageResizingTransformer(size: CGSize(width: 184, height: 112), scaleMode: .aspectFill)
        
      let imageview = cell.viewWithTag(1000) as! UIImageView
      imageview.layer.cornerRadius = 8
        
     imageview.sd_setImage(with: URL(string: movie.screenshots[indexPath.row].link), placeholderImage: nil, context: [.imageTransformer: transformer])
        
        
        
        return cell

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
