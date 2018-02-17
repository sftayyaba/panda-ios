//
//  PNLoginViewController.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNDeliveryTimeViewController: PNBaseViewController {
    
    @IBOutlet var deliveryView: PNDeliveryView!
    
//    @IBOutlet var deliveryTimeTableView: PNDeliveryTimeTableViewDelegateDatasource!
    @IBOutlet var deliveryDateTableView: PNDeliveryDateTableViewDelegateDatasource!

    @IBOutlet weak var deliveryTimeTableView: PNDeliveryDateTableViewDelegateDatasource!
    var dateArray = [String]()
    
    var timeArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.configureNavigationBar()
        
    }
    
    override func doInitialDataLoad() {
        
        self.deliveryView.deliveryTimeLabel.attributedText = NSMutableAttributedString().normal("When: ").redbold(PNUserManager.sharedInstance.selectedTime)

        self.deliveryView.deliveryLabel.attributedText = NSMutableAttributedString().normal("Deliver ").redbold(PNUserManager.sharedInstance.selectedDate)

        
    }
    override func configureNavigationBar() {
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.edgesForExtendedLayout = []
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    func resetTimesTableView(){
        self.deliveryTimeTableView.timesArray = self.configureTimesArray()
        self.deliveryTimeTableView.reloadData()
    }
    
    fileprivate func configureTableView() {
        //Date Setup
        let nib = UINib(nibName: "PNDeliveryDateTableViewCell", bundle: nil)
        self.deliveryDateTableView.register(nib, forCellReuseIdentifier: "PNDeliveryDateTableViewCell")
        
        self.deliveryDateTableView.dateArray = self.configureDaysArray()
        self.deliveryTimeTableView.type = .date
        
        self.deliveryDateTableView.dataSource = self.deliveryDateTableView
        self.deliveryDateTableView.delegate = self.deliveryDateTableView
        
        self.deliveryDateTableView.reloadData()
        
        self.deliveryDateTableView.didSelectDateCallback = {
            
            self.resetTimesTableView()
            
            self.deliveryView.deliveryLabel.attributedText = NSMutableAttributedString().normal("Deliver ").redbold(PNUserManager.sharedInstance.selectedDate)
            
            self.deliveryView.deliveryTimeLabel.attributedText = NSMutableAttributedString().normal("When:")
        }
        
        
        
        
        //Time Setup
        let nib2 = UINib(nibName: "PNDeliveryDateTableViewCell", bundle: nil)
        self.deliveryTimeTableView.register(nib2, forCellReuseIdentifier: "PNDeliveryDateTableViewCell")
        
        
        self.deliveryTimeTableView.timesArray = self.configureTimesArray()
        self.deliveryTimeTableView.type = .time
        
        self.deliveryTimeTableView.dataSource = self.deliveryTimeTableView
        self.deliveryTimeTableView.delegate = self.deliveryTimeTableView
        
        self.deliveryTimeTableView.didSelectTimeCallback = {
            self.deliveryView.deliveryTimeLabel.attributedText = NSMutableAttributedString().normal("When: ").redbold(PNUserManager.sharedInstance.selectedTime)

        }
        self.deliveryTimeTableView.reloadData()
    }

    func configureTimesArray()-> [String]{
        var date = Date()
        let minutes = DateUtils.getMinutes(date)
        
        var numberOfSlots = 6
        if PNUserManager.sharedInstance.selectedDate == "Today"{
            if minutes > 30{
                date = date.addingTimeInterval(60.0 * (60.0 - Double(minutes)))
                
            }else {
                date = date.addingTimeInterval(60.0 * (30.0 - Double(minutes)))
            }
        }else{
            let hours = DateUtils.getHours(date)
            let minutes = DateUtils.getMinutes(date) + 60*hours
            
            date = date.addingTimeInterval(-60.0 *  Double(minutes))
            numberOfSlots = (24 - DateUtils.getHours(date)) * 2

        }

        self.timeArray = [String]()
        self.timeArray.append("ASAP")
        
        for i in 0..<numberOfSlots{
            
            let startSlotTime = date.timeWithPeriod
            let endSlotTime = date.addingTimeInterval(60.0*30.0).timeWithPeriod
            let slotStr = "\(startSlotTime)  -  \(endSlotTime)"
        
            date = date.addingTimeInterval(60.0 * 30.0)

            self.timeArray.append(slotStr)
        }
        
        return self.timeArray
    }
    
    
    func configureDaysArray()-> [String] {
        for i in 0..<7{

            if i == 0{
                self.dateArray.append("Today")
            }else if i == 1 {
                self.dateArray.append("Tomorrow")
            }else {
                self.dateArray.append(Calendar.current.date(byAdding: .day, value: i, to: Date())!.weekdayNameFull)
            }
        }

        return self.dateArray
    }
    
    override func configureCallBacks() {
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        PNUserManager.sharedInstance.logoutUser()
        AppDelegate.sharedInstance()?.moveToSingUp()
    }
}
