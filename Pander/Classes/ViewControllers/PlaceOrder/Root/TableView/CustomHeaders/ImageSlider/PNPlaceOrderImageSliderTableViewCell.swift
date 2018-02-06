//
//  PNPlaceOrderImageSliderTableViewCell.swift
//  Pander
//
//  Created by Shery on 04/02/2018.
//

import UIKit

class PNPlaceOrderImageSliderTableViewCell: UITableViewCell, UIScrollViewDelegate {
    public var didAddItemButtonCallback : (() -> Void)?

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    var numberOfImages: Int = 3
    
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
    }
    
    func configurePageControl() {
        for view in scrollView.subviews{
            view.removeFromSuperview()
        }
        for image in 0..<numberOfImages {
            
            let imageToDisplay = UIImage(named: "bg_photo")
            let imageView = UIImageView(image: imageToDisplay)
            
            let xCoordinate = self.frame.width * CGFloat(image)
            
            self.contentWidth += self.frame.width
            
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: xCoordinate, y: 0, width: self.frame.width, height: 171)
        }
        
        scrollView.contentSize = CGSize(width: contentWidth, height: 171)
       
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
