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
        
        switch(newValue){
        case 0:
            
            self.letsGetStartedWithNewFoodView.sliderValueSmallDescriptionLabel.text = ""
            self.letsGetStartedWithNewFoodView.sliderValueDetailedDescriptionLabel.text = ""
            self.letsGetStartedWithNewFoodView.nextButton.isEnabled = false
            break
        case 1:
            self.letsGetStartedWithNewFoodView.sliderValueSmallDescriptionLabel.text = "Rarely"
            self.letsGetStartedWithNewFoodView.sliderValueDetailedDescriptionLabel.text = "Rarely, I like branching out but only occasionally"
            self.letsGetStartedWithNewFoodView.nextButton.isEnabled = true

            break
        case 2:
            self.letsGetStartedWithNewFoodView.sliderValueSmallDescriptionLabel.text = "Sometimes"
            self.letsGetStartedWithNewFoodView.sliderValueDetailedDescriptionLabel.text = "Sometimes, it's nice to get a change"
            self.letsGetStartedWithNewFoodView.nextButton.isEnabled = true
            break
        case 3:
            self.letsGetStartedWithNewFoodView.sliderValueSmallDescriptionLabel.text = "Frequently"
            self.letsGetStartedWithNewFoodView.sliderValueDetailedDescriptionLabel.text = "Frequently, Most of the time I will try something new"
            self.letsGetStartedWithNewFoodView.nextButton.isEnabled = true
            break
        case 4:
            self.letsGetStartedWithNewFoodView.sliderValueSmallDescriptionLabel.text = "Always"
            self.letsGetStartedWithNewFoodView.sliderValueDetailedDescriptionLabel.text = "Always, I try something new with every possible opportunity"
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
            AppDelegate.sharedInstance()?.moveToHome()
        }) { (error) in
            
        }
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
