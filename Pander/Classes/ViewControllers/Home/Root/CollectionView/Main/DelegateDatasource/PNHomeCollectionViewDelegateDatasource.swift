//
//  PNHomeCollectionViewDelegateDatasource.swift
//  Pander
//
//  Created by Shery on 30/01/2018.
//

import UIKit
import SwiftyJSON

enum PNHomeItemType{
    case cuisine
    case dish
}
class PNHomeCollectionViewDelegateDatasource: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //MARK: Callbacks
    public var didLocationButtonCallback : (() -> Void)?
    public var didDishesButtonCallback : (() -> Void)?
    public var didBudgetButtonCallback : (() -> Void)?
    public var didPeopleButtonCallback : (() -> Void)?
    public var didDeliveryButtonCallback : (() -> Void)?
    public var didFindRestaurentButtonCallback : (() -> Void)?
    public var didSelectCuisineCallback : ((String) -> Void)?

    //MARK: Properties
    var cuisines: [JSON] = []
    var dishes: [JSON] = []
    
    var isSearchRestuarantHidden = true
    var isfeatureItemShowMore = false
    var isCuisineShowMore = true

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (section == 0) && !isSearchRestuarantHidden {
            return 1
        }else if section == 1 && !isfeatureItemShowMore {
            return 1
        }else if section == 1 && isfeatureItemShowMore {
            return self.dishes.count
        }else if section == 2 && !isCuisineShowMore {
            return 1
        }else if section == 2 && isCuisineShowMore {
            return self.cuisines.count
        }else {
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            if indexPath.section == 0{
            let headerView:PHHomeFindRestuarantCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PHHomeFindRestuarantCollectionReusableView", for: indexPath) as! PHHomeFindRestuarantCollectionReusableView
            
            headerView.didMoveDownButtonCallback = {
                self.isSearchRestuarantHidden = false
                self.reloadData()
            }
            
            headerView.didMoveUpButtonCallback = {
                self.isSearchRestuarantHidden = true
                self.reloadData()
            }
            headerView.setContent()
            return headerView
                
            }else if indexPath.section == 1 {

               let headerView:PNHomeFeaturedItemsCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PNHomeFeaturedItemsCollectionReusableView", for: indexPath) as! PNHomeFeaturedItemsCollectionReusableView

                headerView.setContent(title: "Featured Items")
                
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
                
                let headerView:PNHomeFeaturedCuisineCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PNHomeFeaturedCuisineCollectionReusableView", for: indexPath) as! PNHomeFeaturedCuisineCollectionReusableView

                headerView.setContent(title: "Cuisines", isShowMore: self.isCuisineShowMore)
                
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
            let cell:PNHomeMainSeeLessCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNHomeMainSeeLessCollectionViewCell", for: indexPath) as! PNHomeMainSeeLessCollectionViewCell
            
            cell.type = .dish
            
            cell.cuisines = self.cuisines
            cell.dishes = self.dishes
            
            cell.didSelectCuisineCallback = self.didSelectCuisineCallback
            
            cell.collectionView.reloadData()
            
            return cell
        }else if indexPath.section == 1 && isfeatureItemShowMore {
            let cell:PNHomeMainSeeMoreCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNHomeMainSeeMoreCollectionViewCell", for: indexPath) as! PNHomeMainSeeMoreCollectionViewCell
            
            let cuisine = self.dishes[indexPath.row]
            
            let imgUrlStr = cuisine["image_url"].string!
            
            let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryItemExpanded")
            cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
            });
            
            cell.itemLabel.text = cuisine["dish"].string!
            
            return cell
        }else if indexPath.section == 2 && !isCuisineShowMore {
            let cell:PNHomeMainSeeLessCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNHomeMainSeeLessCollectionViewCell", for: indexPath) as! PNHomeMainSeeLessCollectionViewCell

            cell.type = .cuisine
            
            cell.cuisines = self.cuisines
            cell.dishes = self.dishes
            
            cell.didSelectCuisineCallback = self.didSelectCuisineCallback
            
            cell.collectionView.reloadData()
            
            return cell
        }else if indexPath.section == 2 && isCuisineShowMore {
            let cell:PNHomeMainSeeMoreCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNHomeMainSeeMoreCollectionViewCell", for: indexPath) as! PNHomeMainSeeMoreCollectionViewCell
            
            let cuisine = self.cuisines[indexPath.row]
            
            let imgUrlStr = cuisine["image_url"].string!
            
            let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryCuisineExpanded")
            
            cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
            
            });
            
            cell.itemLabel.text = cuisine["cuisine"].string!
            
            return cell
        }else {
            let cell:FindRestuarantCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "FindRestuarantCollectionViewCell", for: indexPath) as! FindRestuarantCollectionViewCell
            
            cell.didDeliveryButtonCallback = self.didDeliveryButtonCallback
            cell.didPeopleButtonCallback = self.didPeopleButtonCallback
            cell.didBudgetButtonCallback = self.didBudgetButtonCallback
            cell.didDishesButtonCallback = self.didDishesButtonCallback
            cell.didLocationButtonCallback = self.didLocationButtonCallback
            cell.didFindRestaurentButtonCallback = self.didFindRestaurentButtonCallback
            cell.setContent()
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.section == 1 && isfeatureItemShowMore {
            let sidelength = self.frame.size.width / 2 - 23;
            return CGSize(width: sidelength , height: sidelength)
        }else if indexPath.section == 1 && !isfeatureItemShowMore {
            return CGSize(width: self.frame.size.width, height: 172)
        }else if indexPath.section == 2 && isCuisineShowMore {
            let sideLength = self.frame.size.width / 2 - 23;
            return CGSize(width: sideLength, height: sideLength)
        }else if indexPath.section == 2 && !isCuisineShowMore {
            return CGSize(width: self.frame.size.width, height: 172)
        }else {
            return CGSize(width: self.frame.size.width, height: 320)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && isfeatureItemShowMore {
            let cuisine = self.dishes[indexPath.row]
            if let callback = didSelectCuisineCallback{
                callback(cuisine["cuisine"].string!)
            }

        }else if indexPath.section == 2 && isCuisineShowMore {
            let cuisine = self.cuisines[indexPath.row]
            if let callback = didSelectCuisineCallback{
                callback(cuisine["cuisine"].string!)
            }
        }
        
    }
}
