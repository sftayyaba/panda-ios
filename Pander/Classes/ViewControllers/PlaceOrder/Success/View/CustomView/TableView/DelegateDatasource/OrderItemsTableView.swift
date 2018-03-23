//
//  OrderItemsTableView.swift
//  Pander
//
//  Created by Aamir Nazir on 20/03/2018.
//

import UIKit

class OrderItemsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    let orderItemCellIdentifier = "OrderItemPopupCell"
    let totalPriceCellIdentifier = "OrderTotalPopupCell"
    var orderItems: [PNOrderDish]?
    var cartItems: [PNCart]?
    var orderRecommendation: PNOrderRecommendation?

    override func awakeFromNib() {
        super.awakeFromNib()

        confirgureTableView()
    }

    func initWith(orderItems: [PNOrderDish]?) {
        self.orderItems = orderItems

        reloadData()
    }

    func initWith(cartItems: [PNCart]?) {
        self.cartItems = cartItems

        reloadData()
    }

    func initWith(orderRecommendation: PNOrderRecommendation?) {
        self.orderRecommendation = orderRecommendation

        reloadData()
    }

    func confirgureTableView() {
        delegate = self
        dataSource = self
        register(UINib(nibName: orderItemCellIdentifier, bundle: nil), forCellReuseIdentifier: orderItemCellIdentifier)
        register(UINib(nibName: totalPriceCellIdentifier, bundle: nil), forCellReuseIdentifier: totalPriceCellIdentifier)
        tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if orderItems != nil && orderItems?.count == indexPath.row || cartItems != nil && cartItems?.count == indexPath.row  {
            let orderRecommendation = PNOrderManager.sharedInstance.generatedOrder?.recommendation
            let totalPrice = OrderTotalCalculator.calculateTotalPrice(orderRecommendation: orderRecommendation)
//            var totalPrice = PNUtils.calculateTotalPrice(orders: orderItems)
//            if cartItems != nil {
//                totalPrice = PNUtils.calculateTotalPrice(orders: cartItems)
//            }

            let cell = tableView.dequeueReusableCell(withIdentifier: totalPriceCellIdentifier) as! OrderTotalPopupCell
            cell.setupCell(totalPrice: totalPrice)

            return cell
        } else if orderItems != nil {
            let orderItem = orderItems?[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: orderItemCellIdentifier) as! OrderItemPopupCell
            cell.setupCell(orderItem: orderItem)

            return cell
        } else {
            let cartItem = cartItems?[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: orderItemCellIdentifier) as! OrderItemPopupCell
            cell.setupCell(cartItem: cartItem)

            return cell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let totalItems = orderItems?.count, totalItems > 0 {
            return totalItems + 1 // +1 for last cell of total amount
        } else if let totalItems = cartItems?.count, totalItems > 0 {
            return totalItems + 1 // +1 for last cell of total amount
        } else {
            return 0
        }
    }
}

