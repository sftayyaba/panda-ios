//
//  PNOrdersCollectionViewDelegateDatasource.swift
//  Pander
//
//  Created by umaid naeem on 2/26/18.
//

import UIKit

class PNOrdersCollectionViewDelegateDatasource: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    public var didSelectCuisineCallback : ((String) -> Void)?
    
    
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
           // return self.dishes.count
            return 10
        }else if section == 2 && !isCuisineShowMore {
            return 1
        }else if section == 2 && isCuisineShowMore {
//            return self.cuisines.count
             return 10
        }else {
            return 0
        }
    }
    
//    - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
             return CGSize(width: self.frame.size.width, height: 150)
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
            
//            cell.type = .dish
//
//            cell.cuisines = self.cuisines
//            cell.dishes = self.dishes
//
            cell.didSelectCuisineCallback = self.didSelectCuisineCallback
            
            cell.collectionView.reloadData()
            
            return cell
        }else if indexPath.section == 0 && isfeatureItemShowMore {
            let cell:PNOrdersMainSeeMoreCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNOrdersMainSeeMoreCollectionViewCell", for: indexPath) as! PNOrdersMainSeeMoreCollectionViewCell
            
//            let cuisine = self.dishes[indexPath.row]
//
//            let imgUrlStr = cuisine["image_url"].string!
//
//            let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryItemExpanded")
//            cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
//            });
//
//            cell.itemLabel.text = cuisine["dish"].string!
            
            return cell
        }else if indexPath.section == 2 && !isCuisineShowMore {
            let cell:PNOrdersMainSeeLessCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNOrdersMainSeeLessCollectionViewCell", for: indexPath) as! PNOrdersMainSeeLessCollectionViewCell
            
//            cell.type = .cuisine
//
//            cell.cuisines = self.cuisines
//            cell.dishes = self.dishes
//
            cell.didSelectCuisineCallback = self.didSelectCuisineCallback
            
            cell.collectionView.reloadData()
            
            return cell
        }else  {
            let cell:PNOrdersMainSeeMoreCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNOrdersMainSeeMoreCollectionViewCell", for: indexPath) as! PNOrdersMainSeeMoreCollectionViewCell
            
//            let cuisine = self.cuisines[indexPath.row]
//
//            let imgUrlStr = cuisine["image_url"].string!
//
//            let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryCuisineExpanded")
//
//            cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
//
//            });
//
//            cell.itemLabel.text = cuisine["cuisine"].string!
            
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
//            let cuisine = self.dishes[indexPath.row]
            if let callback = didSelectCuisineCallback{
//                callback(cuisine["cuisine"].string!)
                callback("Scheduled Order")
            }
            
        }else if indexPath.section == 2 && isCuisineShowMore {
//            let cuisine = self.cuisines[indexPath.row]
            if let callback = didSelectCuisineCallback{
//                callback(cuisine["cuisine"].string!)
                callback("Past Orders")
            }
        }
        
    }
 
}
