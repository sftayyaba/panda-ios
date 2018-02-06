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
import CarbonKit

class PNPlaceOrderAddItemRootViewController: PNBaseViewController,CarbonTabSwipeNavigationDelegate , UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    @IBOutlet weak var navigationBarView: UIView!

    var numberOfImages: Int = 3
    
    var contentWidth:CGFloat = 0.0

    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        
        return PNPlaceOrderAddItemMainViewController(nibName: "PNPlaceOrderAddItemMainViewController", bundle: nil)
//        PNPlaceOrderAddItemMainViewController(coder: CGRect(x: 15, y: 282, width: screenSize.width, height: 30))
    }
    
    
//    func barPosition(for carbonTabSwipeNavigation: CarbonTabSwipeNavigation) -> UIBarPosition {
//        return UIBarPo
//    }
    
    var items = NSArray()
    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    let screenSize: CGRect = UIScreen.main.bounds

    @IBOutlet var placeOrderAddItemRootView: PNPlaceOrderAddItemRootView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
//        let items = ["Features", "Products", "About"]
//        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
//        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        self.configureCarbonSwipeNavigation()
       
        self.scrollView.delegate = self
        
        self.configurePageControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewWillLayoutSubviews() {
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    override func configureCallBacks() {
        
    }

    func configurePageControl() {
        
        for image in 0..<numberOfImages {
            
            let imageToDisplay = UIImage(named: "bg_photo")
            let imageView = UIImageView(image: imageToDisplay)
            
            let xCoordinate = self.view.frame.width * CGFloat(image)
            
            self.contentWidth += self.view.frame.width
            
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: xCoordinate, y: 0, width: self.view.frame.width, height: 171)
        }
        
        scrollView.contentSize = CGSize(width: contentWidth, height: 171)
        
        self.pageControll.numberOfPages = self.numberOfImages
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControll.currentPage = self.scrollView.currentPage
    }
    // MARK: Carboon swipe Navigation
    func configureCarbonSwipeNavigation() -> Void {
        items = ["Main", "Appetizer & small bites", "Dessert", "Drinks"]
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items as [AnyObject], delegate: self)
//        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: self.navigationBarView)
        self.style()
    }
    
    func style() {
        
        let img: UIImage = UIImage()
        self.navigationController!.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController!.navigationBar.tintColor = UIColor(red: 240/255, green: 25/255, blue: 41/255, alpha: 1.0)
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 240/255, green: 25/255, blue: 41/255, alpha: 1.0)
        self.navigationController!.navigationBar.barStyle = .blackTranslucent
        carbonTabSwipeNavigation.toolbar.isTranslucent = true
        carbonTabSwipeNavigation.toolbar.barTintColor = UIColor.white
        carbonTabSwipeNavigation.setIndicatorColor(UIColor(red: 240/255, green: 25/255, blue: 41/255, alpha: 1.0))

//        carbonTabSwipeNavigation.setTabBarHeight(100)
        carbonTabSwipeNavigation.setNormalColor(UIColor.white)
        
        let selectedColor: UIColor =  UIColor.black
        carbonTabSwipeNavigation.setNormalColor(selectedColor, font: UIFont.boldSystemFont(ofSize: 14.0))
        carbonTabSwipeNavigation.setSelectedColor(UIColor.black, font: UIFont.boldSystemFont(ofSize: 14.0))
        carbonTabSwipeNavigation.carbonSegmentedControl?.backgroundColor = (UIColor.white)
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
