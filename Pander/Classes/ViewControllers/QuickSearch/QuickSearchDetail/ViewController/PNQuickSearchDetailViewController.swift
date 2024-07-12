//
//  PNQuickSearchDetailViewController.swift
//  Pander
//
//  Created by umaid naeem on 3/7/18.
//

import UIKit

class PNQuickSearchDetailViewController: PNBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func configureNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.edgesForExtendedLayout = []
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
