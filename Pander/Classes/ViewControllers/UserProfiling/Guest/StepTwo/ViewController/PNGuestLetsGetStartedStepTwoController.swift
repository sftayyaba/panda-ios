//
//  PNLoginViewController.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit
import Alamofire
import OnebyteSwiftNetworkCycle
import FacebookLogin
import GoogleSignIn

class PNGuestLetsGetStartedStepTwoController: PNBaseViewController {
    
    @IBOutlet var guestLetsGetStartedWithEmailView: PNGuestLetsGetStartedWithEmailView!
    
    @IBOutlet var collectionView: PNStepTwoCollectionViewDelegateDatasource!

    let cusines = ["Tech", "Design", "Humor", "Travel", "Music", "Writing", "Social Media", "Life", "Education", "Edtech", "Education Reform", "Photography", "Startup", "Poetry", "Women In Tech", "Female Founders", "Business", "Fiction", "Love", "Food", "Sports"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureObjetc()
    }
    
    fileprivate func configureObjetc() {
        let cellNib = UINib(nibName: "PNGuestLetGetStartedStepTwoCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "PNGuestLetGetStartedStepTwoCollectionViewCell")
        self.collectionView.backgroundColor = UIColor.clear
        
//        self.jobsListDataSource = self.jobsListView.jobsListTableView
        self.collectionView.cusines = self.cusines
        self.collectionView.dataSource = self.collectionView
        self.collectionView.delegate = self.collectionView as! UICollectionViewDelegate
        self.collectionView.reloadData()

    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let viewController = PNGuestLetsGetStartedWithLocationController(nibName: "PNGuestLetsGetStartedWithLocationController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        let viewController = PNGuestLetsGetStartedViewController(nibName: "PNGuestLetsGetStartedViewController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
