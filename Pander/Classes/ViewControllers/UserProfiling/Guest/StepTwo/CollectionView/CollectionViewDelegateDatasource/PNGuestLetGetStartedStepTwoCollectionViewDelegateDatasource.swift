//
//  PNGuestLetGetStartedStepTwoCollectionViewDelegateDatasource.swift
//  Pander
//
//  Created by Shery on 10/01/2018.
//

import UIKit

class PNStepTwoCollectionViewDelegateDatasource: UICollectionView,UICollectionViewDataSource {
    var cusines = [String]()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cusines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PNGuestLetGetStartedStepTwoCollectionViewCell", for: indexPath) as! PNGuestLetGetStartedStepTwoCollectionViewCell
        self.configureCell(cell: cell, forIndexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: PNGuestLetGetStartedStepTwoCollectionViewCell, forIndexPath indexPath: NSIndexPath) {
        let tag = cusines[indexPath.row]
        cell.titleLabel.text = tag
    }
}
