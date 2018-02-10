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

class PNGuestLetsGetStartedWithNewFoodController: PNBaseViewController {
    
    @IBOutlet var letsGetStartedWithNewFoodView: PNGuestLetsGetStartedWithNewFoodView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func configureView() {
        self.letsGetStartedWithNewFoodView.sliderView.setThumbImage(UIImage.circle(diameter: 12.0, color: UIColor.red), for: UIControlState.normal)
        
        self.letsGetStartedWithNewFoodView.sliderView.setThumbImage(UIImage.circle(diameter: 12.0, color: UIColor.red), for: UIControlState.highlighted)
        
        self.letsGetStartedWithNewFoodView.sliderView.setThumbImage(UIImage.circle(diameter: 12.0, color: UIColor.red), for: UIControlState.focused)
    }
    
    
    @IBAction func sliderChangeEnded(_ sender: UISlider) {
        
        let slider = sender
        
        let newValue = Int(slider.value.rounded())
        
        slider.setValue(Float(newValue), animated: false)

        PNUserManager.sharedInstance.adventure = newValue;

        switch(newValue){
        case 0:
            
            self.letsGetStartedWithNewFoodView.sliderValueSmallDescriptionLabel.text = "Never"
            self.letsGetStartedWithNewFoodView.sliderValueDetailedDescriptionLabel.text = "I know what I like, why mess with it?"
            self.letsGetStartedWithNewFoodView.nextButton.isEnabled = true
            break
        case 1:
            self.letsGetStartedWithNewFoodView.sliderValueSmallDescriptionLabel.text = "Rarely"
            self.letsGetStartedWithNewFoodView.sliderValueDetailedDescriptionLabel.text = "I like branching out, but only occasionally"
            self.letsGetStartedWithNewFoodView.nextButton.isEnabled = true

            break
        case 2:
            self.letsGetStartedWithNewFoodView.sliderValueSmallDescriptionLabel.text = "Sometimes"
            self.letsGetStartedWithNewFoodView.sliderValueDetailedDescriptionLabel.text = "It's nice to get a change"
            self.letsGetStartedWithNewFoodView.nextButton.isEnabled = true
            break
        case 3:
            self.letsGetStartedWithNewFoodView.sliderValueSmallDescriptionLabel.text = "Often"
            self.letsGetStartedWithNewFoodView.sliderValueDetailedDescriptionLabel.text = "There's so much out there to experience"
            self.letsGetStartedWithNewFoodView.nextButton.isEnabled = true
            break
        case 4:
            self.letsGetStartedWithNewFoodView.sliderValueSmallDescriptionLabel.text = "Always"
            self.letsGetStartedWithNewFoodView.sliderValueDetailedDescriptionLabel.text = "Why eat the same thing twice?"
            self.letsGetStartedWithNewFoodView.nextButton.isEnabled = true
            break
        default:
            
            break
            
        }
    }

    @IBAction func dietryRestrictionsPressed(_ sender: Any) {
        
        let viewController = PNGuestLetsGetStartedWithDietaryRestrictionController(nibName: "PNGuestLetsGetStartedWithDietaryRestrictionController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
//        let viewController = PNGuestLetsGetStartedStepTwoController(nibName: "PNGuestLetsGetStartedStepTwoController", bundle: nil)
//        self.navigationController?.pushViewController(viewController, animated: true)
        
        PNUserManager.sharedInstance.updateTastePreferencesWith(SuccessBlock: { (response) in
            AppDelegate.sharedInstance()?.moveToHome(atTab: AppDelegate.PNHomeTabs.home)
        }) { (error) in
            
        }
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
