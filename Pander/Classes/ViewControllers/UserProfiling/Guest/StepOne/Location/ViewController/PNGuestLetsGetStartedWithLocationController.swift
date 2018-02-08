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

enum PNLocationViewControllerMode{
    case email
    case zipCode
}

class PNGuestLetsGetStartedWithLocationController: PNBaseViewController {
    
    @IBOutlet weak var zipView: UIView!
    @IBOutlet weak var emailLocationView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationErrorLabel: UILabel!
    
    @IBOutlet weak var submitEmail: UIButton!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var tryAnotherLocation: UILabel!
    
    @IBOutlet var guestLetsGetStartedWithLocationView: PNGuestLetsGetStartedWithLocationView!
    
    var mode: PNLocationViewControllerMode = .zipCode
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        if mode == .email{
            emailLocationView.isHidden = false
            locationErrorLabel.isHidden = true
            guestLetsGetStartedWithLocationView.nextButton.isHidden = true
            zipView.isHidden = true
            titleLabel.text = "Enter your email address below"
            titleLabel.textAlignment = NSTextAlignment.center
            
            let gesture = UITapGestureRecognizer.init(target: self, action: #selector(self.tapAnotherLocationLabel))
            self.tryAnotherLocation.addGestureRecognizer(gesture)
            
        }
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
                    self.locationErrorLabel.isUserInteractionEnabled = true
                    let gesture = UITapGestureRecognizer.init(target: self, action: #selector(self.tapErrorLabel))
                    self.locationErrorLabel.addGestureRecognizer(gesture)

                }else{
                    self.alert(title: "Error", message: "Something went wrong")
                }
                
            })
            
        }
        
    }
    
    @objc func tapErrorLabel(sender:UITapGestureRecognizer){
        let text = (locationErrorLabel.text)
        let termsRange = (text! as NSString).range(of: "tap here")
        if sender.didTapAttributedTextInLabel(label: locationErrorLabel, inRange: termsRange) {
            
            moveToSubscribeWithEmail()
        
        }  else {
            print("Tapped none")
        }
        
    }
    
    
    
    @objc func tapAnotherLocationLabel(sender:UITapGestureRecognizer){
        let text = (tryAnotherLocation.text)
        let termsRange = (text! as NSString).range(of: "try another location")
        if sender.didTapAttributedTextInLabel(label: tryAnotherLocation, inRange: termsRange) {
            
            backButtonTapped(sender)
            
        }  else {
            print("Tapped none")
        }
        
    }
    
    
    
    
    func moveToSubscribeWithEmail(){
        let locationViewController = PNGuestLetsGetStartedWithLocationController(nibName: "PNGuestLetsGetStartedWithLocationController", bundle: nil)
        locationViewController.mode = .email
        self.navigationController?.pushViewController(locationViewController, animated: true)
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
        if mode == .email{
            AppDelegate.sharedInstance()?.moveToSingUp()
        }else{
            self.navigationController?.popViewController(animated:true)
        }
        
    }

    @IBAction func submitEmailPressed(_ sender: UIButton) {
        
        if let email =  self.emailField.text{
            if (!email.isEmail){
                self.alert(title: "Oops", message: "Invalid email");
            return;
        }
        }
        PNUserManager.sharedInstance.registerForUpdates(Zip: PNUserManager.sharedInstance.selectedUnsupportedZip!, Email: self.emailField.text!, CountryCode: "US", SuccessBlock: { (codeRes) in
            self.emailLocationView.isHidden = true
            self.guestLetsGetStartedWithLocationView.confirmationLabel.isHidden = false
        }) { (err) in
            self.emailLocationView.isHidden = true
            self.guestLetsGetStartedWithLocationView.confirmationLabel.isHidden = false
        }
        
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset =  CGPoint(x:(labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
