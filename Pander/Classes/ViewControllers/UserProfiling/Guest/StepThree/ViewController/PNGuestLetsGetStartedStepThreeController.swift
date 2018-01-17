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

    var cusines = JSON.init(parseJSON:"[]").array

    var mainCuisines = JSON.init(parseJSON:"[]").array
    
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
        
        self.collectionView.cusines = cusines!
        self.collectionView.dataSource = self.collectionView
        self.collectionView.delegate = self.collectionView
        self.collectionView.reloadData()
        
        self.flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        self.guestLetsGetStartedStepThreeView.textChangedCallback = {
            text in
            self.cusines = self.mainCuisines?.filter({ (cusineJson) -> Bool in
                
                let dict = cusineJson.dictionary
                let cusineName = dict?["dish"]?.string
                if let tag = cusineName{
                    if tag.lowercased().contains(text.lowercased()){
                        return true
                    }
                }
                return false
            })
            if let cusines = self.cusines{
                self.collectionView.cusines = cusines
            }
            if text == ""{
                self.collectionView.cusines = self.mainCuisines!
            }
            self.collectionView.reloadData()
            
        }
        
        
        
        self.collectionView.cuisineSelectedCallback = {
            selectedCount in
            if selectedCount > 0 {
                self.guestLetsGetStartedStepThreeView.nextButton.isEnabled = true
            } else {
                self.guestLetsGetStartedStepThreeView.nextButton.isEnabled = false
            }
        }

    }
    
    
    override func doInitialDataLoad() {
        PNUserManager.sharedInstance.getRecommendationsForSelectedZip(SuccessBlock: { (recommendations) in
            if let cuisines = recommendations.deliveryRecs?.dishesByZip?[PNUserManager.sharedInstance.selectedZip!].array{
                self.collectionView.cusines = cuisines

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
