//
//  OnboardingViewController.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 12.02.2024.
//

import UIKit

class OnboardingViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var arraySlides = [["firstSlide", "ÖZINŞE-ге қош келдің!","Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити-шоулар, аниме және тағы басқалары"], ["secondSlide", "ÖZINŞE-ге қош келдің!", "Кез келген құрылғыдан қара Сүйікті фильміңді  қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара"], ["thirdSlide", "ÖZINŞE-ге қош келдің!", "Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз"]]
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = ""
    }
    
    @objc func nextButtonTouched() {
        let signInViewController = storyboard?.instantiateViewController(withIdentifier: "SingInViewController")
        navigationController?.show(signInViewController!, sender: self)
    }
    
    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySlides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let imageview = cell.viewWithTag(1000) as! UIImageView
        imageview.image = UIImage(named: arraySlides[indexPath.row][0])
        
        let titleLabel = cell.viewWithTag(1001) as! UILabel
        titleLabel.text = arraySlides[indexPath.row][1]
        
        let description = cell.viewWithTag(1002) as! UILabel
        description.text = arraySlides[indexPath.row][2]
        
        let button = cell.viewWithTag(1003) as! UIButton
        button.layer.cornerRadius = 8
        if indexPath.row == 2 {
            button.isHidden = true
        }
        button.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        
        let nextButton = cell.viewWithTag(1004) as! UIButton
        nextButton.layer.cornerRadius = 12
        if indexPath.row != 2 {
            nextButton.isHidden = true
        }
        nextButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
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
