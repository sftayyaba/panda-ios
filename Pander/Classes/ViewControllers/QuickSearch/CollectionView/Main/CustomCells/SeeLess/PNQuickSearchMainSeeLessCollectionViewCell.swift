//
//  PNQuickSearchMainSeeLessCollectionViewCell.swift
//  Pander
//
//  Created by umaid naeem on 2/28/18.
//

import UIKit
import SDWebImage
import SwiftyJSON

class PNQuickSearchMainSeeLessCollectionViewCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var cuisines: [JSON] = []
    var dishes: [JSON] = []
    
    var type: PNQuickSearchItemType = PNQuickSearchItemType.cuisine
    
    //MARK: Callback
    public var didSelectCuisineCallback : ((String) -> Void)?
    
    @IBOutlet var collectionView: PNQuickSearchCollectionSeeLessViewDelegateDatasource!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register((UINib(nibName: "PNQuickSearchSeeLessCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "PNQuickSearchSeeLessCollectionViewCell")
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
        
//        return self.type == .cuisine ? self.cuisines.count : self.dishes.count
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:PNQuickSearchSeeLessCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PNQuickSearchSeeLessCollectionViewCell", for: indexPath) as! PNQuickSearchSeeLessCollectionViewCell
        
        if self.type == .cuisine{
            
//            let cuisine = self.cuisines[indexPath.row]
//
            let imgUrlStr = "https://desolate-everglades-24260.herokuapp.com/api/v2/image/bg_greek"
            let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryCuisineInline")
            cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
            });
            
//            cell.itemDetailLabel.text = cuisine["cuisine"].string!
//            cell.itemDetailLabel.text = "Cuisine"
        }else{
            
//            let cuisine = self.dishes[indexPath.row]
//
            let imgUrlStr = "https://desolate-everglades-24260.herokuapp.com/api/v2/image/bg_greek"
            let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryItemInline")
            cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
            });
            
//            cell.itemDetailLabel.text = cuisine["dish"].string!
//            cell.itemDetailLabel.text = "Umaid"
            
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.type == .cuisine {
             return CGSize(width: 132, height: 173)
        }else if self.type == .dish {
            return CGSize(width: 172, height: 173)
        }else {
             return CGSize(width: 132, height: 173)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.type == .cuisine{
            
            let cuisine = self.cuisines[indexPath.row]
            if let callback = didSelectCuisineCallback{
//                callback(cuisine["cuisine"].string!)
                callback("Cuisine")
            }
        }else{
            
            let cuisine = self.dishes[indexPath.row]
            if let callback = didSelectCuisineCallback{
//                callback(cuisine["cuisine"].string!)
                callback("Umaid")
            }
        }
    }

}
