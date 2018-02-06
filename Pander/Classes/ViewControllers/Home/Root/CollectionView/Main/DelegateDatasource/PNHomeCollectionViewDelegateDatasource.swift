//
//  PNHomeCollectionViewDelegateDatasource.swift
//  Pander
//
//  Created by Shery on 30/01/2018.
//

import UIKit

class PNHomeCollectionViewDelegateDatasource: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //MARK: Callbacks
    public var didLocationButtonCallback : (() -> Void)?
    public var didDishesButtonCallback : (() -> Void)?
    public var didBudgetButtonCallback : (() -> Void)?
    public var didPeopleButtonCallback : (() -> Void)?
    public var didDeliveryButtonCallback : (() -> Void)?
    public var didFindRestaurentButtonCallback : (() -> Void)?

    //MARK: Properties
    var isSearchRestuarantHidden = true
    var isfeatureItemShowMore = false
    var isCuisineShowMore = false

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (section == 0) && !isSearchRestuarantHidden {
            return 1
        }else if section == 1 && !isfeatureItemShowMore {
            return 1
        }else if section == 1 && isfeatureItemShowMore {
            return 6
        }else if section == 2 && !isCuisineShowMore {
            return 1
        }else if section == 2 && isCuisineShowMore {
            return 6
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
                
                headerView.setContent(title: "Cuisines")
                
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
            
            return cell
        }else if indexPath.section == 1 && isfeatureItemShowMore {
            let cell:PNHomeMainSeeMoreCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNHomeMainSeeMoreCollectionViewCell", for: indexPath) as! PNHomeMainSeeMoreCollectionViewCell
            
            return cell
        }else if indexPath.section == 2 && !isCuisineShowMore {
            let cell:PNHomeMainSeeLessCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNHomeMainSeeLessCollectionViewCell", for: indexPath) as! PNHomeMainSeeLessCollectionViewCell
            
            return cell
        }else if indexPath.section == 2 && isCuisineShowMore {
            let cell:PNHomeMainSeeMoreCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PNHomeMainSeeMoreCollectionViewCell", for: indexPath) as! PNHomeMainSeeMoreCollectionViewCell
            
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
}
