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

class PNPartySizeViewController: PNBaseViewController {
    
    @IBOutlet var partySizeView: PNPartySizeView!
    
    @IBOutlet var collectionView: PNPartySizeCollectionViewDelegateDatasource!
  
    @IBOutlet var tableView: PNPartySizeTableViewDelegateDatasource!

    @IBOutlet weak var flowLayout: FlowLayout!
    var sizingCell: PNPartySizeCollectionViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.configureTableView()
    }
    
    override func configureCallBacks() {
        self.tableView.didSelectFriendCallback = {
            self.partySizeView.selectedFriendsViewHeight.constant = 50
        }
    }
    
    fileprivate func configureCollectionView() {
        let cellNib = UINib(nibName: "PNPartySizeCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "PNPartySizeCollectionViewCell")
        self.collectionView.backgroundColor = UIColor.clear
        
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! PNPartySizeCollectionViewCell?
        
        self.collectionView.sizingCell = self.sizingCell
        
        self.collectionView.dataSource = self.collectionView
        self.collectionView.delegate = self.collectionView
        self.collectionView.reloadData()
    }

    fileprivate func configureTableView() {
        let cellNib = UINib(nibName: "PNPartySizeTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "PNPartySizeTableViewCell")
        
        self.tableView.dataSource = self.tableView
        self.tableView.delegate = self.tableView
        self.tableView.reloadData()
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
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
