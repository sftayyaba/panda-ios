//
//  JNBaseView.swift
//  JobsNow
//
//  Created by Onebyte on 10/25/17.
//  Copyright © 2017 iDevz. All rights reserved.
//

import Foundation
import UIKit

class PNBaseTableViewDelegateDataSource : NSObject,UITextFieldDelegate{
    
    
    //MARK: CallBacks
    var addButtonPressedCallBack: (()->Void)?
    
    var cookButtonPressedCallBack: (()->Void)?
    var waiterButtonPressedCallBack: (()->Void)?

    func addRowsToTableView(_ tableView: UITableView!, numberOfRows: Int ){
        //MARK: need to be changed latter
        tableView.reloadData()
        
    }
 
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        return true
    }
    
}

