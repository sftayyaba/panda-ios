//
//  PartySizeCollectionViewDelegateDatasource.swift
//  Pander
//
//  Created by Shery on 17/01/2018.
//

import Foundation
import UIKit
import SwiftyJSON

class PNPartySizeCollectionViewDelegateDatasource: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var cusines = [JSON]()
    
    var selectedCusines = [JSON]()
    
    var sizingCell: PNPartySizeCollectionViewCell?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PNPartySizeCollectionViewCell", for: indexPath) as! PNPartySizeCollectionViewCell
        self.configureCell(cell: cell, forIndexPath: indexPath as IndexPath)
        return cell
    }
    
    func configureCell(cell: PNPartySizeCollectionViewCell, forIndexPath indexPath: IndexPath) {
//        let dict = cusines[indexPath.row].dictionary
//        let cusineName = dict?["cuisine"]?.string
//        if let tag = cusineName{
//
//            let cuisine = cusines[indexPath.row]
//
//            cell.titleLabel.text = tag
//
//            if self.selectedCusines.contains(cuisine){
//                cell.backgroundColor = cell.tintColor
//                cell.titleLabel.textColor = UIColor.white
//            }else{
//                cell.backgroundColor = UIColor.customTagsBackgroundColor()
//                cell.titleLabel.textColor = UIColor.black
//
//            }
//        }
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
        
        collectionView.reloadData()
    }
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    //    }
}
