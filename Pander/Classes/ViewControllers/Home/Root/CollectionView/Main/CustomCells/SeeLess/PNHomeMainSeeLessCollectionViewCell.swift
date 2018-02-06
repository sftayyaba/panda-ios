//
//  PNHomeMainSeeLessCollectionViewCell.swift
//  Pander
//
//  Created by Shery on 03/02/2018.
//

import UIKit

class PNHomeMainSeeLessCollectionViewCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: PNHomeCollectionSeeLessViewDelegateDatasource!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register((UINib(nibName: "PNHomeSeeLessCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "PNHomeSeeLessCollectionViewCell")
        self.configureHorizontalCollectionView()
    }
    
    fileprivate func configureHorizontalCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.collectionView.reloadData()
    }
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:PNHomeSeeLessCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PNHomeSeeLessCollectionViewCell", for: indexPath) as! PNHomeSeeLessCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 175, height: 173)
    }
}
