//
//  PNPlaceOrderImageSliderTableViewCell.swift
//  Pander
//
//  Created by Shery on 04/02/2018.
//

import UIKit

class PNPlaceOrderImageSliderTableViewCell: UITableViewCell, UIScrollViewDelegate {
    public var didAddItemButtonCallback : (() -> Void)?

    @IBOutlet weak var restaurentNameLabel: UILabel!
    @IBOutlet weak var minimumOrderLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    var numberOfImages: Int = 1
    
    var contentWidth:CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.scrollView.delegate = self
        
        self.configurePageControl()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func didMoveToSuperview() {
        self.configurePageControl()
        loadDataToViews()
    }
    
    func loadDataToViews(){
        self.restaurentNameLabel.text = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.restaurantInfo?.name
        if let minOrder = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.restaurantInfo?.minOrder{
            self.minimumOrderLabel.text = "Minimum order $\(minOrder)"
        }
    }
    
    func configurePageControl() {
        for view in scrollView.subviews{
            view.removeFromSuperview()
        }
        for image in 0..<numberOfImages {
            
            let imageToDisplay = UIImage()
            let imageView = UIImageView(image: imageToDisplay)
            
            if let imgUrlStr = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.imageUrl{
            
                let imgUrl = URL(string: imgUrlStr)
                
                imageView.sd_setImage(with: imgUrl , completed: { (img, err, type, url) in
                    print("image loaded")
                })
                
            }
            let xCoordinate = self.frame.width * CGFloat(image)
            
            self.contentWidth += self.frame.width
            
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: xCoordinate, y: 0, width: self.frame.width, height: 171)
            imageView.contentMode = UIViewContentMode.scaleAspectFill
        }
        
        scrollView.contentSize = CGSize(width: contentWidth, height: 171)
        scrollView.isScrollEnabled = false
        scrollView.isPagingEnabled = false
        self.pageControll.numberOfPages = self.numberOfImages
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControll.currentPage = self.scrollView.currentPage
    }
    @IBAction func addNewItemPressed(_ sender: UIButton) {
        if let callBack = didAddItemButtonCallback{
            callBack()
        }
    }
}

extension UIScrollView {
    var currentPage:Int{
        return Int((self.contentOffset.x+(0.5*self.frame.size.width))/self.frame.width)
    }
}
