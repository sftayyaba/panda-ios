//
//  PNQuickSearchCollectionViewDelegateDatasource.swift
//  Pander
//
//  Created by umaid naeem on 2/28/18.
//

import UIKit
import SwiftyJSON

enum PNQuickSearchItemType{
    case cuisine
    case dish
    case category
}

class PNQuickSearchCollectionViewDelegateDatasource: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

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
    var isCuisineShowMore = false
    var isCategories = false
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (section == 0) && !isSearchRestuarantHidden {
            return 1
        }else if section == 1 && !isfeatureItemShowMore {
            return 1
        }else if section == 1 && isfeatureItemShowMore {
//            return self.dishes.count
            return 10
        }else if section == 2 && !isCuisineShowMore {
            return 1
        }else if section == 2 && isCuisineShowMore {
            return 10
        }else if section == 3 && !isCategories {
            return 1
        }else if section == 3 && isCategories {
            return 10
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            if indexPath.section == 0{
                let headerView:PHQuickSearchFindRestuarantCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PHQuickSearchFindRestuarantCollectionReusableView", for: indexPath) as! PHQuickSearchFindRestuarantCollectionReusableView
                
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
                
                let headerView:PNQuickSearchFeaturedItemsCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PNQuickSearchFeaturedItemsCollectionReusableView", for: indexPath) as! PNQuickSearchFeaturedItemsCollectionReusableView
                
                headerView.setContent(title: "filtered by ambience...")
                
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
                
                let headerView:PNQucikSearchFeaturedCuisineCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PNQucikSearchFeaturedCuisineCollectionReusableView", for: indexPath) as! PNQucikSearchFeaturedCuisineCollectionReusableView
                
                headerView.setContent(title: "...Cuisines", isShowMore: self.isCuisineShowMore)
                
                headerView.didMoveUpButtonCallback = {
                    self.isCuisineShowMore = false
                    self.reloadData()
                }
                
                headerView.didMoveDownButtonCallback = {
                    self.isCuisineShowMore = true
                    self.reloadData()
                }
                
                return headerView
            }else if indexPath.section == 3 {
                
                let headerView:PNQucikSearchCategoriesCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PNQucikSearchCategoriesCollectionReusableView", for: indexPath) as! PNQucikSearchCategoriesCollectionReusableView
                
                headerView.setContent(title: "...Or these suggested categories", isShowMore: self.isCategories)
                
                headerView.didMoveUpButtonCallback = {
                    self.isCategories = false
                    self.reloadData()
                }
                
                headerView.didMoveDownButtonCallback = {
                    self.isCategories = true
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
            let cell:PNQuickSearchMainSeeLessCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNQuickSearchMainSeeLessCollectionViewCell", for: indexPath) as! PNQuickSearchMainSeeLessCollectionViewCell
            cell.backgroundColor = UIColor.yellow

            cell.type = .dish
//
//            cell.cuisines = self.cuisines
//            cell.dishes = self.dishes
            
            cell.didSelectCuisineCallback = self.didSelectCuisineCallback
            
            cell.collectionView.reloadData()
            
            return cell
        }else if indexPath.section == 1 && isfeatureItemShowMore {
            let cell:PNQuickSearchMainSeeMoreCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNQuickSearchMainSeeMoreCollectionViewCell", for: indexPath) as! PNQuickSearchMainSeeMoreCollectionViewCell
            
//            let cuisine = self.dishes[indexPath.row]
//
            let imgUrlStr = "https://desolate-everglades-24260.herokuapp.com/api/v2/image/bg_greek"

            let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryItemExpanded")
            cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
            });
//
//            cell.itemLabel.text = cuisine["dish"].string!
            
            return cell
        }else if indexPath.section == 2 && !isCuisineShowMore {
            let cell:PNQuickSearchMainSeeLessCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNQuickSearchMainSeeLessCollectionViewCell", for: indexPath) as! PNQuickSearchMainSeeLessCollectionViewCell
            
            cell.type = .cuisine
//
//            cell.cuisines = self.cuisines
//            cell.dishes = self.dishes
            
            cell.didSelectCuisineCallback = self.didSelectCuisineCallback
            
            cell.collectionView.reloadData()
            
            return cell
        }else if indexPath.section == 2 && isCuisineShowMore {
            let cell:PNQuickSearchMainSeeMoreCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNQuickSearchMainSeeMoreCollectionViewCell", for: indexPath) as! PNQuickSearchMainSeeMoreCollectionViewCell
            
//            let cuisine = self.cuisines[indexPath.row]
//
            let imgUrlStr = "https://desolate-everglades-24260.herokuapp.com/api/v2/image/bg_greek"

            let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryCuisineExpanded")

            cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in

            });
//
//            cell.itemLabel.text = cuisine["cuisine"].string!
            
            return cell
        }else if indexPath.section == 3 && !isCategories {
            let cell:PNQuickSearchMainSeeLessCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNQuickSearchMainSeeLessCollectionViewCell", for: indexPath) as! PNQuickSearchMainSeeLessCollectionViewCell
            
                        cell.type = .category
            //
            //            cell.cuisines = self.cuisines
            //            cell.dishes = self.dishes
            
            cell.didSelectCuisineCallback = self.didSelectCuisineCallback
            
            cell.collectionView.reloadData()
            
            return cell
        }else if indexPath.section == 3 && isCategories {
            let cell:PNQuickSearchMainSeeMoreCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNQuickSearchMainSeeMoreCollectionViewCell", for: indexPath) as! PNQuickSearchMainSeeMoreCollectionViewCell
            
            //            let cuisine = self.cuisines[indexPath.row]
            //
                        let imgUrlStr = "https://desolate-everglades-24260.herokuapp.com/api/v2/image/bg_greek"
            //
                        let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryCuisineExpanded")
            
                        cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
            
                        });
            //
            //            cell.itemLabel.text = cuisine["cuisine"].string!
            
            return cell
        }else {
            let cell:QuickSearchFindRestuarantCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "QuickSearchFindRestuarantCollectionViewCell", for: indexPath) as! QuickSearchFindRestuarantCollectionViewCell
            
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
        }else if indexPath.section == 3 && isCategories {
            let sideLength = self.frame.size.width / 2 - 23;
            return CGSize(width: sideLength, height: sideLength)
        }else if indexPath.section == 3 && !isCategories {
            return CGSize(width: self.frame.size.width, height: 172)
        }else {
            return CGSize(width: self.frame.size.width, height: 320)
        }
    }

}
