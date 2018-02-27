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
        PNUserManager.sharedInstance.getCards(SuccessBlock: { (response) in
            
            var cardarray = response.cards
            
            if response.cards?.count != 0 {
                PNUserManager.sharedInstance.selectedCard=response.cards?[0]
                if let selectedCard = PNUserManager.sharedInstance.selectedCard{
                    
                    //((PNUserManager.sharedInstance.selectedCard?.nick != nil ? PNUserManager.sharedInstance.selectedCard?.nick : PNUserManager.sharedInstance.selectedCard!.type! + PNUserManager.sharedInstance.selectedCard!.lastFour!)!)
                }
            }
            
        }
            , FailureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    //(self.alert(title: "Oops", message: localError.localizedDescription)
                }else {
                    // self.alert(title: "Error", message: "Something went wrong !")
                }
                
        })
        
        PNUserManager.sharedInstance.getAddresses(SuccessBlock: { (response) in
            
            if let addresses = response.addresses{
                //self.locationTableView.addresses = addresses
                if addresses.count != 0 {
//                    self.labelDeliverToLocation.attributedText = NSMutableAttributedString()
//                        .normal(normalText)
//                        .bold((PNUserManager.sharedInstance.selectedAddress?.nick != nil ? PNUserManager.sharedInstance.selectedAddress?.nick : PNUserManager.sharedInstance.selectedAddress?.street)!)
                }
            }
            
        }
            , FailureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    //self.alert(title: "Oops", message: localError.localizedDescription)
                }else {
                    // self.alert(title: "Error", message: "Something went wrong !")
                }
                
        })
        
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
    
    override func configureCallBacks() {
        
        self.ordersView.collectionView.didSelectCuisineCallback = {
            cuisine in
//            if var cuisines = PNUserManager.sharedInstance.homeSelectedCuisines{
//                cuisines.append(cuisine)
//            }else{
//                PNUserManager.sharedInstance.homeSelectedCuisines = [cuisine]
//            }
            
//            self.findRestaurentButtonPressed(self.homeView)
            let viewController = PNOrderDetailViewController(nibName: "PNOrderDetailViewController", bundle: nil)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
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
