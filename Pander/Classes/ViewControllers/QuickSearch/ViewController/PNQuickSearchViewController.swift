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

class PNQuickSearchViewController: PNBaseViewController {
    
    @IBOutlet var quickSearchView: PNQuickSearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.quickSearchView.collectionView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.quickSearchView.collectionView.reloadData()
        self.doInitialDataLoad()
    }
    
    //MARK: Loading/Methods
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
//            self.quickSearchView.collectionView.dishes = dishes
//            self.quickSearchView.collectionView.cuisines = cuisines
//
            self.quickSearchView.collectionView.reloadData()
//
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
    
    override func configureNavigationBar() {
        //        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.edgesForExtendedLayout = []
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    
    override func configureCallBacks() {
//        self.quickSearchView.collectionView.didDeliveryButtonCallback = {
//            self.deliverASAPButtonPressed(self.homeView)
//        }
//
//        self.quickSearchView.collectionView.didPeopleButtonCallback = {
//            self.peopleButtonPressed(self.homeView)
//        }
//
//        self.quickSearchView.collectionView.didBudgetButtonCallback = {
//            self.budgetButtonPressed(self.homeView)
//        }
//
//        self.quickSearchView.collectionView.didDishesButtonCallback = {
//            self.dishesButtonPressed(self.homeView)
//        }
//
//        self.quickSearchView.collectionView.didLocationButtonCallback = {
//            self.locationButtonPressed(self.homeView)
//        }
//
//        self.quickSearchView.collectionView.didFindRestaurentButtonCallback = {
//            self.findRestaurentButtonPressed(self.homeView)
//        }
        
        self.quickSearchView.collectionView.didSelectCuisineCallback = {
            cuisine in
            if var cuisines = PNUserManager.sharedInstance.homeSelectedCuisines{
                cuisines.append(cuisine)
            }else{
                PNUserManager.sharedInstance.homeSelectedCuisines = [cuisine]
            }
            
//            self.findRestaurentButtonPressed(self.homeView)
        }
    }
    
    
    fileprivate func configureCollectionView () {
        
        self.quickSearchView.collectionView.delegate = self.quickSearchView.collectionView
        self.quickSearchView.collectionView.dataSource = self.quickSearchView.collectionView
        
        
        
        let nib = UINib(nibName: "QuickSearchFindRestuarantCollectionViewCell", bundle: nil)
        
        let headerNib = UINib(nibName: "PHQuickSearchFindRestuarantCollectionReusableView", bundle: nil)
        
        self.quickSearchView.collectionView.register(nib , forCellWithReuseIdentifier: "QuickSearchFindRestuarantCollectionViewCell")
        
        self.quickSearchView.collectionView.register(UINib(nibName: "PNQuickSearchMainSeeLessCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "PNQuickSearchMainSeeLessCollectionViewCell")
        
        
        self.quickSearchView.collectionView.register(UINib(nibName: "PNQuickSearchMainSeeMoreCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "PNQuickSearchMainSeeMoreCollectionViewCell")
        
        self.quickSearchView.collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PHQuickSearchFindRestuarantCollectionReusableView")
        
        self.quickSearchView.collectionView.register((UINib(nibName: "PNQuickSearchFeaturedItemsCollectionReusableView", bundle: nil)), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PNQuickSearchFeaturedItemsCollectionReusableView")
        
        self.quickSearchView.collectionView.register((UINib(nibName: "PHCommonHeaderCollectionView", bundle: nil)), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PHCommonHeaderCollectionView")
        
        self.quickSearchView.collectionView.register((UINib(nibName: "PNQucikSearchFeaturedCuisineCollectionReusableView", bundle: nil)), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PNQucikSearchFeaturedCuisineCollectionReusableView")
        
        self.quickSearchView.collectionView.register((UINib(nibName: "PNQucikSearchCategoriesCollectionReusableView", bundle: nil)), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PNQucikSearchCategoriesCollectionReusableView")
        
        self.quickSearchView.collectionView.reloadData()
    }
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        PNUserManager.sharedInstance.logoutUser()
        AppDelegate.sharedInstance()?.moveToSingUp()
    }
}
