//
//  PNHomeMainSeeLessCollectionViewCell.swift
//  Pander
//
//  Created by Shery on 03/02/2018.
//

import UIKit
import SDWebImage
import SwiftyJSON

class PNHomeMainSeeLessCollectionViewCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var cuisines: [JSON] = []
    var dishes: [JSON] = []
    
    var type: PNHomeItemType = PNHomeItemType.cuisine
    
    //MARK: Callback
    public var didSelectCuisineCallback : ((String) -> Void)?

    
    
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
        
        return self.type == .cuisine ? self.cuisines.count : self.dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:PNHomeSeeLessCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PNHomeSeeLessCollectionViewCell", for: indexPath) as! PNHomeSeeLessCollectionViewCell
        
        if self.type == .cuisine{
            
            let cuisine = self.cuisines[indexPath.row]
            
            let imgUrlStr = cuisine["image_url"].string!
            let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryCuisineInline")
            cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
            });
            
            cell.itemDetailLabel.text = cuisine["cuisine"].string!
        }else{
            
            let cuisine = self.dishes[indexPath.row]
            
            let imgUrlStr = cuisine["image_url"].string!
            let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryItemInline")
            cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
            });
            
            cell.itemDetailLabel.text = cuisine["dish"].string!
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 175, height: 101)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.type == .cuisine{
            
            let cuisine = self.cuisines[indexPath.row]
            if let callback = didSelectCuisineCallback{
                callback(cuisine["cuisine"].string!)
            }
        }else{
            
            let cuisine = self.dishes[indexPath.row]
            if let callback = didSelectCuisineCallback{
                callback(cuisine["cuisine"].string!)
            }
        }
    }
}
