//
//  OrderDetailsView.swift
//  Pander
//
//  Created by Aamir Nazir on 19/03/2018.
//

import UIKit

class OrderDetailsView: UIView {

    // MARK: Properties
    let nibName = "OrderDetailsView"
    let blurViewAlpha: CGFloat = 0.85
    let popupAnimationDuration: CFTimeInterval = 0.3
    var backgroundBlurView = UIView()
    var tapGesture = UITapGestureRecognizer()
    var selectedPickerValue: String?
    @IBOutlet weak var orderItemsTableView: OrderItemsTableView!
    
    // MARK: IBOutlet
    @IBOutlet weak var containerView: UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        commonInit()
    }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    private func commonInit() {
        let view = (Bundle.main.loadNibNamed(nibName, owner: self, options: nil)!.last as? UIView)!
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)

        containerView.roundCorner(radius: 3.0)
    }
    
    func showOn(view: UIView, orderItems: [PNOrderDish]?, cartItems: [PNCart]?) {
        orderItemsTableView.initWith(orderItems: orderItems)
        orderItemsTableView.initWith(cartItems: cartItems)

        // Add Blur background view
        setupBlurViewWithTapGesture(frame: view.frame)
        frame.origin.y = view.frame.maxY
        view.addSubview(backgroundBlurView)

        // Add picker view popup as subview
        view.addSubview(self)

        // Show picker view popup on screen in animated style
        UIView.animate(withDuration: popupAnimationDuration, animations: {
            [weak self] in
            self?.slideInAnimations(view: view)
        })
    }

    @objc func dismissValuePickerPopup() {
        UIView.animate(withDuration: popupAnimationDuration, animations: {
            [weak self] in
            self?.slideOutAnimations()
            }, completion: {
                [weak self] _ in
                self?.dismissAnimationCompletionAction()
        })
    }

    func slideInAnimations(view: UIView) {
        backgroundBlurView.alpha = blurViewAlpha
        frame.origin.y = 100.0
    }

    func slideOutAnimations() {
        backgroundBlurView.alpha = 0.0
        frame.origin.y = superview?.frame.maxY ?? -frame.height // as an fallback, it slides up
    }

    func dismissAnimationCompletionAction() {
        backgroundBlurView.removeGestureRecognizer(tapGesture)
        backgroundBlurView.removeFromSuperview()
    }

    private func setupBlurViewWithTapGesture(frame: CGRect) {
        backgroundBlurView = UIView(frame: frame)
        backgroundBlurView.backgroundColor = .black
        backgroundBlurView.alpha = 0.0

        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissValuePickerPopup))
        backgroundBlurView.addGestureRecognizer(tapGesture)
    }

    // MARK: IBAction

    @IBAction func doneBtnPressed(_ sender: Any) {
        dismissValuePickerPopup()
    }
}
