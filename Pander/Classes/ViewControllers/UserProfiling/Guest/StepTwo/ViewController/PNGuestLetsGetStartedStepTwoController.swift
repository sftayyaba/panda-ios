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

class PNGuestLetsGetStartedStepTwoController: PNBaseViewController {
    
    @IBOutlet var guestLetsGetStartedStepTwoView: PNGuestLetsGetStartedStepTwoView!
    
    @IBOutlet var collectionView: PNStepTwoCollectionViewDelegateDatasource!

    @IBOutlet weak var flowLayout: FlowLayout!
    var sizingCell: PNGuestLetGetStartedStepTwoCollectionViewCell?
    
    var cusines = JSON.init(parseJSON:"[]").array

    var mainCuisines = JSON.init(parseJSON:"[]").array
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureObjetc()

    }
    
    fileprivate func configureObjetc() {
        let cellNib = UINib(nibName: "PNGuestLetGetStartedStepTwoCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "PNGuestLetGetStartedStepTwoCollectionViewCell")
        self.collectionView.backgroundColor = UIColor.clear
        
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! PNGuestLetGetStartedStepTwoCollectionViewCell?
        
        self.collectionView.sizingCell = self.sizingCell
        
//        self.jobsListDataSource = self.jobsListView.jobsListTableView
        
        self.collectionView.cusines = cusines!
        
        self.collectionView.dataSource = self.collectionView
        self.collectionView.delegate = self.collectionView
        self.collectionView.reloadData()
        
        self.flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        self.guestLetsGetStartedStepTwoView.textChangedCallback = {
            text in
            self.cusines = self.mainCuisines?.filter({ (cusineJson) -> Bool in
                
                let dict = cusineJson.dictionary
                let cusineName = dict?["cuisine"]?.string
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
                self.guestLetsGetStartedStepTwoView.nextButton.isEnabled = true
            } else {
                self.guestLetsGetStartedStepTwoView.nextButton.isEnabled = false
            }
        }
    }
    
    
    override func doInitialDataLoad() {
        PNUserManager.sharedInstance.getRecommendationsForSelectedZip(SuccessBlock: { (recommendations) in
            if let cuisines = recommendations.deliveryRecs?.cuisinesByZip?[PNUserManager.sharedInstance.selectedZip!].array{
                
                self.cusines = cuisines
                self.mainCuisines = cuisines
                
                self.collectionView.cusines = cuisines
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
            PNUserManager.sharedInstance.selectedCusines = self.collectionView.selectedCusines
        }else{
            PNUserManager.sharedInstance.selectedCusines = nil
        }
        
        let viewController = PNGuestLetsGetStartedStepThreeController(nibName: "PNGuestLetsGetStartedStepThreeController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
