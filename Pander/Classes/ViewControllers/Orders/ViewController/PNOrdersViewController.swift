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
            if response.cards?.count != 0 {
                PNUserManager.sharedInstance.selectedCard = response.cards?[0]
                if PNUserManager.sharedInstance.selectedCard != nil{
                }
            }
        }
            , FailureBlock: { (error) in
                if (error as? ErrorBaseClass) != nil{
                    //(self.alert(title: "Oops", message: localError.localizedDescription)
                }else {
                    // self.alert(title: "Error", message: "Something went wrong !")
                }
                
        })
        
        PNUserManager.sharedInstance.getAddresses(SuccessBlock: { (response) in
            if let addresses = response.addresses{
                if addresses.count != 0 {
                    PNUserManager.sharedInstance.selectedAddress = addresses[0]
                }
            }
        }
            , FailureBlock: { (error) in
                if (error as? ErrorBaseClass) != nil{
                    //self.alert(title: "Oops", message: localError.localizedDescription)
                }else {
                    // self.alert(title: "Error", message: "Something went wrong !")
                }
        })
        
        
        PNOrderManager.sharedInstance.getPastOrder(SuccessBlock: { (response) in
            print("Response is ",response);
            guard let responseOrders = response.orders else {return}
            
            var pastOrders: [PNOrders] = []
            var scheduledOrders: [PNOrders] = []
            
            for order in responseOrders {
                let deliveryDateString = order.deliveryDate!
               
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                let date: Date? = dateFormatterGet.date(from: deliveryDateString)
                
                let currentDate = Date()


                let dateOrder = Calendar.current.compare(date!, to: currentDate, toGranularity:.day)
                switch dateOrder {
                case .orderedDescending:
                    print("DESCENDING")
                    scheduledOrders.append(order)
                case .orderedAscending:
                    print("ASCENDING,PAST")
                    pastOrders.append(order)
                case .orderedSame:
                    print("SAME")
                    scheduledOrders.append(order)
                }
            }
            
            self.ordersView.collectionView.pastOrders = pastOrders
            self.ordersView.collectionView.scheduledOrders = scheduledOrders
            self.ordersView.collectionView.reloadData()
            
        }) { (error) in
            if let localError = error as? ErrorBaseClass{
                self.alert(title: "Oops", message: localError.localizedDescription)
            }else{
                self.alert(title: "Error", message: "Something went wrong")
            }
        }
        
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
            cuisine,order in
            let viewController = PNOrderDetailViewController(nibName: "PNOrderDetailViewController", bundle: nil)
            viewController.cuisine = cuisine
            viewController.order = order
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
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
}

extension Date {
    func dateWithoutTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short    //02/15/17
        let str = dateFormatter.string(from: self)
        return dateFormatter.date(from: str)!
    }
    
    func isAfterThanDate(dateToCompare: Date) -> Bool {
        var isGreater = false
        
        if self.compare(dateToCompare) == .orderedDescending {
            isGreater = true
        }
        
        return isGreater
    }
}
