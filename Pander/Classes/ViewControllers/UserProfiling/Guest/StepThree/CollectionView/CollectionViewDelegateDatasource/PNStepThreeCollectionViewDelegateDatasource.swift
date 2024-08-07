//
//  PNGuestLetGetStartedStepTwoCollectionViewDelegateDatasource.swift
//  Pander
//
//  Created by Shery on 10/01/2018.
//

import UIKit
import SwiftyJSON

class PNStepThreeCollectionViewDelegateDatasource: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    var cusines = [String]()
    
    var selectedCusines = [String]()
    
    var cuisineSelectedCallback: ((Int)->())?

    
    var sizingCell: PNGuestLetGetStartedStepThreeCollectionViewCell?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cusines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PNGuestLetGetStartedStepThreeCollectionViewCell", for: indexPath) as! PNGuestLetGetStartedStepThreeCollectionViewCell
        self.configureCell(cell: cell, forIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: PNGuestLetGetStartedStepThreeCollectionViewCell, forIndexPath indexPath: IndexPath) {
            let cuisine = cusines[indexPath.row]
            
        cell.titleLabel.text = cuisine.replacingOccurrences(of: "_", with: "/")

            
            if self.selectedCusines.contains(cuisine){
                cell.backgroundColor = AppDelegate.sharedInstance()?.window!.tintColor
                cell.titleLabel.textColor = UIColor.white
            }else{
                cell.backgroundColor = UIColor.customTagsBackgroundColor()
                cell.titleLabel.textColor = UIColor.black
                
            }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.configureCell(cell: self.sizingCell!, forIndexPath: indexPath)
        let size = self.sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        return size;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCusine = self.cusines[indexPath.row]
        
        if let alreadySelectedIndex = self.selectedCusines.index(of: selectedCusine){
            self.selectedCusines.remove(at: alreadySelectedIndex)
        }else{
            self.selectedCusines.append(selectedCusine)
        }
        
        if let callBack = cuisineSelectedCallback{
            callBack(self.selectedCusines.count)
        }

        collectionView.reloadData()
    }}
