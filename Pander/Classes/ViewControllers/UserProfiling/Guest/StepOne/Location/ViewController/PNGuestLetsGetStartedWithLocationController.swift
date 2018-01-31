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

class PNGuestLetsGetStartedWithLocationController: PNBaseViewController {
    
    @IBOutlet weak var zipView: UIView!
    @IBOutlet weak var emailLocationView: UIView!
    @IBOutlet weak var locationErrorLabel: UILabel!
    @IBOutlet weak var submitEmail: UIButton!
    @IBOutlet weak var tryAnotherLocation: UILabel!
    @IBOutlet var guestLetsGetStartedWithLocationView: PNGuestLetsGetStartedWithLocationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.guestLetsGetStartedWithLocationView.setNextButtonState()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {

        if let zip = self.guestLetsGetStartedWithLocationView.zipCodeTextField.text{
            PNUserManager.sharedInstance.checkAddressIsSupported(Zip: zip, SuccessBlock: {
                successResponse in

                self.moveToNext()
                
            }, FailureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    self.locationErrorLabel.isHidden = false
// Uncomment the code below to listen tap gestures for label
                    //                    self.locationErrorLabel.isUserInteractionEnabled = true
//                    var gesture = UITapGestureRecognizer.init(target: self, action: #selector(self.tapErrorLabel))
//                    self.locationErrorLabel.addGestureRecognizer(gesture)
//
                }else{
                    self.alert(title: "Error", message: "Something went wrong")
                }
                
            })
            
        }
        
    }
    
    @objc func tapErrorLabel(sender:UITapGestureRecognizer){
        let text = (locationErrorLabel.text)
        let termsRange = (text! as NSString).range(of: "tap here")
//        if sender.didTapAttributedTextInLabel(locationErrorLabel, inRange: termsRange) {
//            print("Tapped terms")
//        }  else {
//            print("Tapped none")
//        }
        
        emailLocationView.isHidden = false
        locationErrorLabel.isHidden = true
        guestLetsGetStartedWithLocationView.nextButton.isHidden = true
        zipView.isHidden = true
    }
    
    
    func moveToNext(){
        if PNUserManager.sharedInstance.user != nil || PNUserManager.sharedInstance.guestUser != nil{
            let viewController = PNGuestLetsGetStartedStepTwoController(nibName: "PNGuestLetsGetStartedStepTwoController", bundle: nil)
            self.navigationController?.pushViewController(viewController, animated: true)
        }else{
            let viewController = PNGuestLetsGetStartedWithNameController(nibName: "PNGuestLetsGetStartedWithNameController", bundle: nil)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
//        let viewController = PNGuestLetsGetStartedWithNameController(nibName: "PNGuestLetsGetStartedWithNameController", bundle: nil)
        self.navigationController?.popViewController(animated:true)
    }
}
