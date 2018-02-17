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

class PNFavoriteDishesController: PNBaseViewController {
    
    @IBOutlet var favoriteDishesView: PNFavoriteDishesView!
    
    @IBOutlet var collectionView: PNFavoriteDishesCollectionViewDelegateDatasource!

    @IBOutlet weak var flowLayout: FlowLayout!
    var sizingCell: PNFavoriteDishesCollectionViewCell?
    
    var cusines = [String]()

    var mainCuisines = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureObjetc()
    }
    
    fileprivate func configureObjetc() {
        let cellNib = UINib(nibName: "PNFavoriteDishesCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "PNFavoriteDishesCollectionViewCell")
        self.collectionView.backgroundColor = UIColor.clear
        
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! PNFavoriteDishesCollectionViewCell?
        
        self.collectionView.sizingCell = self.sizingCell
        
//        self.jobsListDataSource = self.jobsListView.jobsListTableView
        
        self.collectionView.cusines = cusines
        
        self.collectionView.dataSource = self.collectionView
        self.collectionView.delegate = self.collectionView
        self.collectionView.reloadData()
        
        self.flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        self.favoriteDishesView.textChangedCallback = {
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
                
                PNUserManager.sharedInstance.homeSelectedCuisines = self.collectionView.selectedCusines
            } else {
            }
        }
    }
    
    
    override func doInitialDataLoad() {
        PNUserManager.sharedInstance.getAllCuisines(SuccessBlock: { (recommendations) in
            if let cuisines = recommendations.cuisines{
                
                if let selectedCuisines = PNUserManager.sharedInstance.homeSelectedCuisines{
                    self.collectionView.selectedCusines = selectedCuisines
                }

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
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

