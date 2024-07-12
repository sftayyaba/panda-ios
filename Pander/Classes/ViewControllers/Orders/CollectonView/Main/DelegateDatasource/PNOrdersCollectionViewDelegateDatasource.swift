//
//  PNOrdersCollectionViewDelegateDatasource.swift
//  Pander
//
//  Created by umaid naeem on 2/26/18.
//

import UIKit
import SwiftyJSON

class PNOrdersCollectionViewDelegateDatasource: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    public var didSelectCuisineCallback : ((String,PNOrders) -> Void)?
    
    //MARK: Properties
    var pastOrders: [PNOrders] = []
    var scheduledOrders: [PNOrders] = []
    
    
    
    
    var isfeatureItemShowMore = false
    var isCuisineShowMore = true
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
           return 0
        }else if section == 1 && !isfeatureItemShowMore {
            return 1
        }else if section == 1 && isfeatureItemShowMore {
            return self.scheduledOrders.count
        }else if section == 2 && !isCuisineShowMore {
            return 1
        }else if section == 2 && isCuisineShowMore {
            return self.pastOrders.count
        }else {
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
             return CGSize(width: self.frame.size.width, height: 80)
        }else {
           return CGSize(width: self.frame.size.width, height: 50)
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            if indexPath.section == 0 {
                let headerView:PNOrderMainHeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PNOrderMainHeaderCollectionReusableView", for: indexPath) as! PNOrderMainHeaderCollectionReusableView
                return headerView
                
            }else if indexPath.section == 1 {
                let headerView:PNScheduledCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PNScheduledCollectionReusableView", for: indexPath) as! PNScheduledCollectionReusableView
                
                headerView.setContent(title: "Scheduled orders")
                
                headerView.didMoveUpButtonCallback = {
                     self.isfeatureItemShowMore = false
                    self.reloadData()
                }
                
                headerView.didMoveDownButtonCallback = {
                    self.isfeatureItemShowMore = true
                    self.reloadData()
                }
                
                return headerView
                
            }else if indexPath.section == 2 {
                
                let headerView:PNPastOrderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PNPastOrderCollectionReusableView", for: indexPath) as! PNPastOrderCollectionReusableView
                
                headerView.setContent(title: "Past orders", isShowMore: self.isCuisineShowMore)
                
                headerView.didMoveUpButtonCallback = {
                    self.isCuisineShowMore = false
                    self.reloadData()
                }
                
                headerView.didMoveDownButtonCallback = {
                     self.isCuisineShowMore = true
                    self.reloadData()
                }
                
                return headerView
            }else {
                let headerView:PHCommonHeaderCollectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PHCommonHeaderCollectionView", for: indexPath) as! PHCommonHeaderCollectionView
                return headerView
            }
        default:
            
            assert(false, "Unexpected element kind")
        }
        
        let headerView:PHCommonHeaderCollectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PHCommonHeaderCollectionView", for: indexPath) as! PHCommonHeaderCollectionView
        
        return headerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 && !isfeatureItemShowMore {
            let cell:PNOrdersMainSeeLessCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNOrdersMainSeeLessCollectionViewCell", for: indexPath) as! PNOrdersMainSeeLessCollectionViewCell
            
            cell.isPastOrder = false
            cell.pastOrders = self.scheduledOrders

            cell.didSelectCuisineCallback = self.didSelectCuisineCallback
            
            cell.collectionView.reloadData()
            
            return cell
        }else if indexPath.section == 1 && isfeatureItemShowMore {
            let cell:PNOrdersMainSeeMoreCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNOrdersMainSeeMoreCollectionViewCell", for: indexPath) as! PNOrdersMainSeeMoreCollectionViewCell
            
            let pastOrder = self.scheduledOrders[indexPath.row]
            let imgUrlStr = pastOrder.imageUrl!

            let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryItemExpanded")
            cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
            });

            let normalText = pastOrder.dishSummary!
            let boldText = "$"+pastOrder.total!.format(f: "") + "  "
            
            cell.itemLabel.attributedText = NSMutableAttributedString().boldPast(boldText).normalPast(normalText)
            
            
            return cell
        }else if indexPath.section == 2 && !isCuisineShowMore {
            let cell:PNOrdersMainSeeLessCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNOrdersMainSeeLessCollectionViewCell", for: indexPath) as! PNOrdersMainSeeLessCollectionViewCell
            
             cell.isPastOrder = true
            cell.pastOrders = self.pastOrders
           
            cell.didSelectCuisineCallback = self.didSelectCuisineCallback
            
            cell.collectionView.reloadData()
            
            return cell
        }else  {
            let cell:PNOrdersMainSeeMoreCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNOrdersMainSeeMoreCollectionViewCell", for: indexPath) as! PNOrdersMainSeeMoreCollectionViewCell
            
            let pastOrder = pastOrders[indexPath.row]
            let imgUrlStr = pastOrder.imageUrl!
            let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryCuisineExpanded")
            cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
            });
            
            
            let deliveryDate = pastOrder.deliveryDate!
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "E MMM d "
            
            let date: Date? = dateFormatterGet.date(from: deliveryDate)
            let boldText = dateFormatterPrint.string(from: date!) + "  "
            
            let normalText = pastOrder.dishSummary!
            cell.itemLabel.attributedText = NSMutableAttributedString().boldPast(boldText).normalPast(normalText)
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 && isfeatureItemShowMore {
            let sidelength = self.frame.size.width / 2 - 23;
            return CGSize(width: sidelength , height: sidelength + 20)
        }else if indexPath.section == 1 && !isfeatureItemShowMore {
            return CGSize(width: self.frame.size.width, height: 172)
        }else if indexPath.section == 2 && isCuisineShowMore {
            let sideLength = self.frame.size.width / 2 - 23;
            return CGSize(width: sideLength, height: sideLength + 20)
        }else if indexPath.section == 2 && !isCuisineShowMore {
            return CGSize(width: self.frame.size.width, height: 172)
        }else {
            return CGSize(width: self.frame.size.width, height: 320)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && isfeatureItemShowMore {
            let pastOrder = scheduledOrders[indexPath.row]
            if let callback = didSelectCuisineCallback{
                callback("0",pastOrder)
            }
            
        }else if indexPath.section == 2 && isCuisineShowMore {
            let pastOrder = pastOrders[indexPath.row]
            if let callback = didSelectCuisineCallback{
                callback("1",pastOrder)
            }
        }
        
    }
 
}
