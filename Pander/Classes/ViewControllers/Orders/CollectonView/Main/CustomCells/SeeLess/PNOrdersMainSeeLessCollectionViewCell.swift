//
//  PNOrdersMainSeeLessCollectionViewCell.swift
//  Pander
//
//  Created by umaid naeem on 2/26/18.
//

import UIKit

class PNOrdersMainSeeLessCollectionViewCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    //MARK: Callback
    public var didSelectCuisineCallback : ((String) -> Void)?
    
    var type: PNHomeItemType = PNHomeItemType.cuisine
    
    @IBOutlet var collectionView: PNOrderCollectionSeeLessViewDelegateDatasource!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register((UINib(nibName: "PNOrdersSeeLessCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "PNOrdersSeeLessCollectionViewCell")
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
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:PNOrdersSeeLessCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PNOrdersSeeLessCollectionViewCell", for: indexPath) as! PNOrdersSeeLessCollectionViewCell
        
//        if self.type == .cuisine{
        
//            let cuisine = self.cuisines[indexPath.row]
//
            let imgUrlStr = "https://desolate-everglades-24260.herokuapp.com/api/v2/image/bg_greek"
            let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryCuisineInline")
            cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
            });
//
//            cell.itemDetailLabel.text = cuisine["cuisine"].string!
//        }else{
        
//            let cuisine = self.dishes[indexPath.row]
//
//            let imgUrlStr = "https://desolate-everglades-24260.herokuapp.com/api/v2/image/bg_greek"
//            let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryItemInline")
//            cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
//            });
//
//            cell.itemDetailLabel.text = cuisine["dish"].string!
            
//        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 175, height: 173)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.type == .cuisine{

//            let cuisine = self.cuisines[indexPath.row]
            if let callback = didSelectCuisineCallback{
//                callback(cuisine["cuisine"].string!)
                callback("Scheduled Order")
            }
        }else{

//            let cuisine = self.dishes[indexPath.row]
            if let callback = didSelectCuisineCallback{
//                callback(cuisine["cuisine"].string!)
                callback("Past Order")
            }
        }
    }

}
