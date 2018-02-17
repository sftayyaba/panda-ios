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
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var collectionView: PNStepTwoCollectionViewDelegateDatasource!

    @IBOutlet weak var flowLayout: FlowLayout!
    var sizingCell: PNGuestLetGetStartedStepTwoCollectionViewCell?
    
    var cusines = [String]()

    var mainCuisines = [String]()
    
    
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
        
        self.collectionView.cusines = cusines
        
        self.collectionView.dataSource = self.collectionView
        self.collectionView.delegate = self.collectionView
        self.collectionView.reloadData()
        
        self.flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        self.guestLetsGetStartedStepTwoView.textChangedCallback = {
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
        backButton.isHidden = PNUserManager.sharedInstance.guestUser == nil ? true : false
        self.collectionView.cuisineSelectedCallback = {
            selectedCount in
            self.setupNextButton(count: selectedCount)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNextButton(count: self.collectionView.selectedCusines.count)
    }
    
    func setupNextButton(count: Int){
        if count > 2 {
            PNUserManager.sharedInstance.selectedCusines = self.collectionView.selectedCusines
            self.guestLetsGetStartedStepTwoView.nextButton.isEnabled = true
        } else {
            self.guestLetsGetStartedStepTwoView.nextButton.isEnabled = false
        }
    }
    
    override func doInitialDataLoad() {
        PNUserManager.sharedInstance.getAllCuisines(SuccessBlock: { (recommendations) in
            if let cuisines = recommendations.cuisines{
                
                if let selectedCuisines = PNUserManager.sharedInstance.selectedCusines{
                    self.collectionView.selectedCusines = selectedCuisines
                }

                self.cusines = cuisines
                self.mainCuisines = cuisines
                
                self.collectionView.cusines = cuisines
                self.collectionView.reloadData()
                self.setupNextButton(count: self.collectionView.selectedCusines.count)
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
