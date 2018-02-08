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

class PNHomeViewController: PNBaseViewController {
    
    @IBOutlet var homeView: PNHomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    override func configureView() {
        self.configureCollectionView()
    }
    
    override func configureNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func doInitialDataLoad() {
        PNUserManager.sharedInstance.getRecommendationsForSelectedZip(SuccessBlock: { (recs) in
            let cuisines = PNUserManager.sharedInstance.selectedZip != nil ?
                recs.deliveryRecs!.cuisinesByZip![PNUserManager.sharedInstance.selectedZip!].array! :
                recs.deliveryRecs!.cuisinesByZip!["00000"].array!
            
            let dishes = PNUserManager.sharedInstance.selectedZip != nil ?
                recs.deliveryRecs!.dishesByZip![PNUserManager.sharedInstance.selectedZip!].array! :
                recs.deliveryRecs!.dishesByZip!["00000"].array!
            
            self.homeView.collectionView.dishes = dishes
            self.homeView.collectionView.cuisines = cuisines
            
            self.homeView.collectionView.reloadData()
            
        }) { (error) in
            if let localError = error as? ErrorBaseClass{
                if (localError.devMsg! == "Invalid Authorization"){
                    
                    PNUserManager.sharedInstance.logoutUser()
                    AppDelegate.sharedInstance()?.moveToSingUp()

                }else{
                    self.alert(title: "Oops", message: localError.localizedDescription)
                }
                
            }else{
                self.alert(title: "Error", message: "Something went wrong")
            }
        }
    }
    
    override func configureCallBacks() {
        self.homeView.collectionView.didDeliveryButtonCallback = {
            self.deliverASAPButtonPressed(self.homeView)
        }
        
        self.homeView.collectionView.didPeopleButtonCallback = {
            self.peopleButtonPressed(self.homeView)
        }
        
        self.homeView.collectionView.didBudgetButtonCallback = {
            self.budgetButtonPressed(self.homeView)
        }
        
        self.homeView.collectionView.didDishesButtonCallback = {
            self.dishesButtonPressed(self.homeView)
        }
        
        self.homeView.collectionView.didLocationButtonCallback = {
            self.locationButtonPressed(self.homeView)
        }
        
        self.homeView.collectionView.didFindRestaurentButtonCallback = {
            self.findRestaurentButtonPressed(self.homeView)
        }
    }
    
    @IBAction func searchBarTapped(_ sender: UIButton) {
//        self.alert(title: "!!!", message: "Coming Soon!")
        self.homeView.searchButtonTapped()
    }
    
    fileprivate func configureCollectionView () {
        
        self.homeView.collectionView.delegate = self.homeView.collectionView
        self.homeView.collectionView.dataSource = self.homeView.collectionView
        
        
        
        let nib = UINib(nibName: "FindRestuarantCollectionViewCell", bundle: nil)
        
        let headerNib = UINib(nibName: "PHHomeFindRestuarantCollectionReusableView", bundle: nil)

        self.homeView.collectionView.register(nib , forCellWithReuseIdentifier: "FindRestuarantCollectionViewCell")
        
        self.homeView.collectionView.register(UINib(nibName: "PNHomeMainSeeLessCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "PNHomeMainSeeLessCollectionViewCell")


        self.homeView.collectionView.register(UINib(nibName: "PNHomeMainSeeMoreCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "PNHomeMainSeeMoreCollectionViewCell")
        
        self.homeView.collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PHHomeFindRestuarantCollectionReusableView")
   
        self.homeView.collectionView.register((UINib(nibName: "PNHomeFeaturedItemsCollectionReusableView", bundle: nil)), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PNHomeFeaturedItemsCollectionReusableView")

        self.homeView.collectionView.register((UINib(nibName: "PHCommonHeaderCollectionView", bundle: nil)), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PHCommonHeaderCollectionView")
        
        self.homeView.collectionView.register((UINib(nibName: "PNHomeFeaturedCuisineCollectionReusableView", bundle: nil)), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PNHomeFeaturedCuisineCollectionReusableView")

        self.homeView.collectionView.reloadData()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
//        if let email = self.guestLetsGetStartedWithEmailView.emailTextField.text, let password =
//            self.guestLetsGetStartedWithEmailView.passwordTextField.text {
//            if let email = self.guestLetsGetStartedWithEmailView.emailTextField.text {
//                if email.isEmail {
//                    
//                    
//                    PNUserManager.sharedInstance.signUp(Email: email, Password: password, SuccessBlock: { (successResponse) in
//                        
//                        let viewController = PNGuestLetsGetStartedStepTwoController(nibName: "PNGuestLetsGetStartedStepTwoController", bundle: nil)
//                        self.navigationController?.pushViewController(viewController, animated: true)
//                        
//                    }, FailureBlock: { (error) in
//                        if let localError = error as? ErrorBaseClass{
//                            self.alert(title: "Opss", message: localError.localizedDescription)
//                        }else {
//                            self.alert(title: "Error", message: "Something went wrong !")
//                        }
//                    })
//            
//                }else{
//                    self.alert(title: "Error", message: "Enter valid email.")
//
//                }
//            }else{
//                self.alert(title: "Error", message: "Email and password are required")
//            }
//            
//        }
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        PNUserManager.sharedInstance.logoutUser()
        AppDelegate.sharedInstance()?.moveToSingUp()
    }
    
    @IBAction func locationButtonPressed(_ sender: Any) {
        let viewController = PNLocationViewController(nibName: "PNLocationViewController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func dishesButtonPressed(_ sender: Any) {
        let viewController = PNFavoriteDishesController(nibName: "PNFavoriteDishesController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func budgetButtonPressed(_ sender: Any) {
        let viewController = PNBudgetViewController(nibName: "PNBudgetViewController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func peopleButtonPressed(_ sender: Any) {
        let viewController = PNPartySizeViewController(nibName: "PNPartySizeViewController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func deliverASAPButtonPressed(_ sender: Any) {
        let viewController = PNDeliveryTimeViewController(nibName: "PNDeliveryTimeViewController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func findRestaurentButtonPressed(_ sender: Any) {
        let viewController = PNPlaceOrderViewController(nibName: "PNPlaceOrderViewController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
