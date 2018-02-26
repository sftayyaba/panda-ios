//
//  PNLoginViewController.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit
import Alamofire
import FacebookLogin
import GoogleSignIn

class PNOrdersViewController: PNBaseViewController {
    
    @IBOutlet var ordersView: PNOrdersView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ordersView.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.ordersView.collectionView.reloadData()
        self.doInitialDataLoad()
    }
    
    override func configureNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.edgesForExtendedLayout = []
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        PNUserManager.sharedInstance.logoutUser()
        AppDelegate.sharedInstance()?.moveToSingUp()
    }
    
    
    override func doInitialDataLoad() {
//        PNUserManager.sharedInstance.getRecommendationsForSelectedZip(SuccessBlock: { (recs) in
//            let cuisines = PNUserManager.sharedInstance.selectedZip != nil ?
//                recs.deliveryRecs!.cuisinesByZip![PNUserManager.sharedInstance.selectedZip!].array! :
//                recs.deliveryRecs!.cuisinesByZip!["00000"].array!
//
//            let dishes = PNUserManager.sharedInstance.selectedZip != nil ?
//                recs.deliveryRecs!.dishesByZip![PNUserManager.sharedInstance.selectedZip!].array! :
//                recs.deliveryRecs!.dishesByZip!["00000"].array!
//
//            self.homeView.collectionView.dishes = dishes
//            self.homeView.collectionView.cuisines = cuisines
        
            self.ordersView.collectionView.reloadData()
            
//        }) { (error) in
//            if let localError = error as? ErrorBaseClass{
//                if (localError.devMsg! == "Invalid Authorization"){
//
//                    PNUserManager.sharedInstance.logoutUser()
//                    AppDelegate.sharedInstance()?.moveToSingUp()
//
//                }else{
//                    self.alert(title: "Oops", message: localError.localizedDescription)
//                }
//
//            }else{
//                self.alert(title: "Error", message: "Something went wrong")
//            }
//        }
    }
    
    
    //MARK: Configuration/Methods
    override func configureView() {
        self.configureCollectionView()
    }
    
    fileprivate func configureCollectionView () {
        
        self.ordersView.collectionView.delegate = self.ordersView.collectionView
        self.ordersView.collectionView.dataSource = self.ordersView.collectionView
        
        self.ordersView.collectionView.register(UINib(nibName: "PNOrdersMainSeeLessCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "PNOrdersMainSeeLessCollectionViewCell")
        
        self.ordersView.collectionView.register(UINib(nibName: "PNOrdersMainSeeMoreCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "PNOrdersMainSeeMoreCollectionViewCell")
        
        
        self.ordersView.collectionView.register((UINib(nibName: "PNOrderMainHeaderCollectionReusableView", bundle: nil)), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PNOrderMainHeaderCollectionReusableView")
        
        self.ordersView.collectionView.register((UINib(nibName: "PNPastOrderCollectionReusableView", bundle: nil)), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PNPastOrderCollectionReusableView")
        
        self.ordersView.collectionView.register((UINib(nibName: "PHCommonHeaderCollectionView", bundle: nil)), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PHCommonHeaderCollectionView")
        
        self.ordersView.collectionView.register((UINib(nibName: "PNScheduledCollectionReusableView", bundle: nil)), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PNScheduledCollectionReusableView")
        
        self.ordersView.collectionView.reloadData()
    }
}
