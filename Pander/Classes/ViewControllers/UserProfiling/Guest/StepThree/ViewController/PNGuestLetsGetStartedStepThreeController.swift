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
import SwiftyJSON

class PNGuestLetsGetStartedStepThreeController: PNBaseViewController {
    
    @IBOutlet var guestLetsGetStartedStepThreeView: PNGuestLetsGetStartedStepThreeView!
    
    @IBOutlet var collectionView: PNStepThreeCollectionViewDelegateDatasource!

    @IBOutlet weak var flowLayout: FlowLayout!
    
    var sizingCell: PNGuestLetGetStartedStepThreeCollectionViewCell?

    var cusines = [String]()

    var mainCuisines = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureObjetc()
        
        
    }
    
    fileprivate func configureObjetc() {
        let cellNib = UINib(nibName: "PNGuestLetGetStartedStepThreeCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "PNGuestLetGetStartedStepThreeCollectionViewCell")
        self.collectionView.backgroundColor = UIColor.clear
        
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! PNGuestLetGetStartedStepThreeCollectionViewCell?

//        self.jobsListDataSource = self.jobsListView.jobsListTableView
        
        self.collectionView.sizingCell = self.sizingCell
        
        self.collectionView.cusines = cusines
        self.collectionView.dataSource = self.collectionView
        self.collectionView.delegate = self.collectionView
        self.collectionView.reloadData()
        
        self.flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        self.guestLetsGetStartedStepThreeView.textChangedCallback = {
            text in
            self.cusines = self.mainCuisines.filter({ (cusineJson) -> Bool in
                
                    if cusineJson.lowercased().contains(text.lowercased()){
                        return true
                    }
                return false
            })
            
            self.collectionView.cusines = self.cusines

            if text == ""{
                self.collectionView.cusines = self.mainCuisines
            }
            self.collectionView.reloadData()
            
        }
        
        
        
        self.collectionView.cuisineSelectedCallback = {
            selectedCount in
            if selectedCount > 0 {
                
                PNUserManager.sharedInstance.selectedDishes = self.collectionView.selectedCusines

                self.guestLetsGetStartedStepThreeView.nextButton.setTitle("Next", for: UIControlState.normal)
            } else {
                self.guestLetsGetStartedStepThreeView.nextButton.setTitle("Skip", for: UIControlState.normal)            }
        }

    }
    
    
    override func doInitialDataLoad() {
        PNUserManager.sharedInstance.getAllDishes(SuccessBlock: { (recommendations) in
            if let cuisines = recommendations.dishes{
                self.collectionView.cusines = cuisines
                
                if let selectedCuisines = PNUserManager.sharedInstance.selectedDishes{
                    self.collectionView.selectedCusines = selectedCuisines
                    
                    if selectedCuisines.count > 0 {
                        
                        self.guestLetsGetStartedStepThreeView.nextButton.setTitle("Next", for: UIControlState.normal)
                    } else {
                        self.guestLetsGetStartedStepThreeView.nextButton.setTitle("Skip", for: UIControlState.normal)
                        
                    }
                }
                
                self.cusines = cuisines
                self.mainCuisines = cuisines
                
                self.collectionView.reloadData()
            }
        }) { (error) in
            if let localError = error as? ErrorBaseClass{
                self.alert(title: "Oops", message: localError.localizedDescription)
            }else{
                self.alert(title: "Error", message: "Something went wrong")
            }
        }
    }
    
    
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if self.collectionView.selectedCusines.count > 0 {
            PNUserManager.sharedInstance.selectedDishes = self.collectionView.selectedCusines
        }else{
            PNUserManager.sharedInstance.selectedDishes = nil
        }

        let viewController = PNGuestLetsGetStartedWithNewFoodController(nibName: "PNGuestLetsGetStartedWithNewFoodController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
