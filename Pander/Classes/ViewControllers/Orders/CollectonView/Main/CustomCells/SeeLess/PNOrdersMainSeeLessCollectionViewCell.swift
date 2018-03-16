//
//  PNOrdersMainSeeLessCollectionViewCell.swift
//  Pander
//
//  Created by umaid naeem on 2/26/18.
//

import UIKit

class PNOrdersMainSeeLessCollectionViewCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    //MARK: Callback
    public var didSelectCuisineCallback : ((String,PNOrders) -> Void)?
    
    var type: PNHomeItemType = PNHomeItemType.cuisine
    
    var isPastOrder = Bool()
    
    
    //MARK: Properties
    var pastOrders: [PNOrders] = []
    
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
        
        return self.pastOrders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:PNOrdersSeeLessCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PNOrdersSeeLessCollectionViewCell", for: indexPath) as! PNOrdersSeeLessCollectionViewCell

        let pastOrder = pastOrders[indexPath.row]
        let imgUrlStr = pastOrder.imageUrl!
        
        let imgUrl = URL(string: "\(imgUrlStr)?imageType=deliveryCuisineInline")
        cell.itemImageView.sd_setImage(with: imgUrl, completed: { (img, err, type, url) in
        });
        
        
        
        if isPastOrder {
            let deliveryDate = pastOrder.deliveryDate!
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "E MMM d "
            
            let date: Date? = dateFormatterGet.date(from: deliveryDate)
            let boldText = dateFormatterPrint.string(from: date!) + "  "
            
            let normalText = pastOrder.dishSummary!
            cell.itemDetailLabel.attributedText = NSMutableAttributedString().boldPast(boldText).normalPast(normalText)
        }else {
            let normalText = pastOrder.dishSummary!
            let boldText = "$"+pastOrder.total!.format(f: "") + "  "
            cell.itemDetailLabel.attributedText = NSMutableAttributedString().boldPast(boldText).normalPast(normalText)
        }
        
        
       
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 175, height: 173)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let pastOrder = pastOrders[indexPath.row]
        
        if self.type == .cuisine{
            if let callback = didSelectCuisineCallback{
                callback("0",pastOrder)
            }
        }else{
            if let callback = didSelectCuisineCallback{
                callback("1",pastOrder)
            }
        }
    }

}
