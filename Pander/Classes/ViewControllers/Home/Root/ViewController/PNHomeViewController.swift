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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.homeView.collectionView.reloadData()
    }
    
    //MARK: Loading/Methods
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
    
    
    //MARK: Configuration/Methods
    override func configureView() {
        self.configureCollectionView()
    }
    
    override func configureNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
        
        self.homeView.collectionView.didSelectCuisineCallback = {
            cuisine in
            if var cuisines = PNUserManager.sharedInstance.homeSelectedCuisines{
                cuisines.append(cuisine)
            }else{
                PNUserManager.sharedInstance.homeSelectedCuisines = [cuisine]
            }
            
            self.findRestaurentButtonPressed(self.homeView)
        }
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
    
    
    
    
    //MARK: Action/Methods
    
    @IBAction func searchBarTapped(_ sender: UIButton) {
//        self.alert(title: "!!!", message: "Coming Soon!")
        self.homeView.searchButtonTapped()
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
        var searchAddress = ""
        var city = ""
        var zip = ""
        var addressId = ""
        let category = 2
        var cuisine = ""
        let groupSize = PNUserManager.sharedInstance.groupSize
        let budgetPerPerson = PNUserManager.sharedInstance.budgetPerPerson
        let orderMode = 0
        
        if let selectedAddress = PNUserManager.sharedInstance.selectedAddress{
            searchAddress = "\(selectedAddress.street!),\(selectedAddress.zipCode!)"
            city = selectedAddress.city!
            zip = selectedAddress.zipCode!
            addressId = "\(selectedAddress.locationId!)"
        }else{
            self.alert(title: "Oops", message: "No Delivery address is selected.")
            return
        }
        
        if let selectedCuisines = PNUserManager.sharedInstance.homeSelectedCuisines{
            cuisine = selectedCuisines.joined(separator: ",")
        }else{
            self.alert(title: "Oops", message: "No Cuisine is selected.")
            return
        }
        
        if let selectedCard = PNUserManager.sharedInstance.selectedCard{
//            cuisine = selectedCuisines.joined(separator: ",")
        }else{
            self.alert(title: "Oops", message: "No Card is selected.")
            return
        }
        PNOrderManager.sharedInstance.generateOrder(SearchAddress: searchAddress, AddressCity: city, AddressZip: zip, AddressId: addressId, Catergory: category, Cuisine: cuisine, GroupSize: groupSize, BudgetPerPerson: budgetPerPerson, OrderMode: orderMode, RestsTried: nil, SuccessBlock: { (generatedOrderResponse) in
            
            PNOrderManager.sharedInstance.getGeneratedOrder(TaskId: generatedOrderResponse.id!, SuccessBlock: { (orderReponse) in


                let viewController = PNPlaceOrderViewController(nibName: "PNPlaceOrderViewController", bundle: nil)
                
                self.navigationController?.pushViewController(viewController, animated: true)

            }, FailureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    self.alert(title: "Oops", message: localError.localizedDescription)
                }else{
                    self.alert(title: "Error", message: "Something went wrong")
                }
            })
            
        }) { (error) in
            if let localError = error as? ErrorBaseClass{
                self.alert(title: "Oops", message: localError.localizedDescription)
            }else{
                self.alert(title: "Error", message: "Something went wrong")
            }
        }
        
        
    }

}
