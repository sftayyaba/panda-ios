//
//  PNOrderDetailImageSliderTableViewCell.swift
//  Pander
//
//  Created by umaid naeem on 2/27/18.
//

import UIKit

class PNOrderDetailImageSliderTableViewCell: UITableViewCell, UIScrollViewDelegate {
    public var didAddItemButtonCallback : (() -> Void)?

    @IBOutlet weak var restaurentNameLabel: UILabel!
    @IBOutlet weak var minimumOrderLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var orderdOnLbl: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var numberOfImages: Int = 1
    
    var contentWidth:CGFloat = 0.0
    
    
    var order : PNOrders!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.scrollView.delegate = self
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
        self.restaurentNameLabel.text = self.order.name
//        if let minOrder = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.restaurantInfo?.minOrder{
//            self.minimumOrderLabel.text = "Minimum order $\(minOrder)"
//        }
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
    
    
    func setContent(cuisine:String,order:PNOrders) {
        self.order = order
        if cuisine == "0" {
            print("Scheduled Order",order.deliveryDate!)
            let orderDateString = order.deliveryDate!
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "d MMM yyyy"
            
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            
            let date: Date? = dateFormatterGet.date(from: orderDateString)
            let dateText = dateFormatterPrint.string(from: date!) + "  "
            
            let time : Date? = dateFormatterGet.date(from: orderDateString)
            let timeString = timeFormatter.string(from: time!) + "  "
            
            print(dateText,timeString)

            
            self.orderdOnLbl.text = dateText
            self.orderdOnLbl.font = UIFont(name: "AvenirNext-Bold", size: 13)
            self.orderdOnLbl.textColor = UIColor.black
            
            self.dateLabel.text = timeString
            self.dateLabel.textColor = UIColor.red
            self.dateLabel.font = UIFont(name: "AvenirNext-Bold", size: 12)
            
            
        }else {
            print("Past Order",order.deliveryDate!)
            let orderDateString = order.deliveryDate!
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "d MMM yyyy"
            
            let date: Date? = dateFormatterGet.date(from: orderDateString)
            let dateText = dateFormatterPrint.string(from: date!) + "  "
            
            self.dateLabel.text = dateText


        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControll.currentPage = self.scrollView.currentPage
    }
    
}
