//
//  OrderTotalCalculator.swift
//  Pander
//
//  Created by Aamir Nazir on 23/03/2018.
//

import UIKit

class OrderTotalCalculator: NSObject {

    static func calculateTotalPrice(orderRecommendation: PNOrderRecommendation?) -> Float {
        let dishSubtotal = calculateDishSubtotal(orderDishes: orderRecommendation?.order)
        let totalFees = calculateTotalFees(orderRecommendation: orderRecommendation)
        let totalSalesTax = calculateTotalSalesTax(orderRecommendation: orderRecommendation)

        return dishSubtotal + totalFees + totalSalesTax
    }

    private static func calculateDishSubtotal(orderDishes: [PNOrderDish]?) -> Float {
        return orderDishes?.reduce(0.0, { ($0 + (($1.unitPrice ?? 0.0) * Float($1.qty ?? 0))) }) ?? 0.0
    }

    private static func calculateTotalFees(orderRecommendation: PNOrderRecommendation?) -> Float {
        let dishSubtotal = calculateDishSubtotal(orderDishes: orderRecommendation?.order)
        let totalFlatUntaxed = calculateTotalFlatUntaxed(fees: orderRecommendation?.fees)
        let totalFlatTaxed = calculateTotalFlatTaxed(fees: orderRecommendation?.fees)
        let totalPctTaxed = calculateTotalPctTaxed(fees: orderRecommendation?.fees, dishSubtotal: dishSubtotal)
        let totalPctUntaxed = calculateTotalPctUntaxed(fees: orderRecommendation?.fees, dishSubtotal: dishSubtotal)

        return totalFlatUntaxed + totalPctUntaxed + totalFlatTaxed + totalPctTaxed
    }

    private static func calculateTotalSalesTax(orderRecommendation: PNOrderRecommendation?) -> Float {
        let dishSubtotal = calculateDishSubtotal(orderDishes: orderRecommendation?.order)
        let totalFlatTaxed = calculateTotalFlatTaxed(fees: orderRecommendation?.fees)
        let totalPctTaxed = calculateTotalPctTaxed(fees: orderRecommendation?.fees, dishSubtotal: dishSubtotal)

        return ((orderRecommendation?.fees?.salesTax ?? 0.0) * (dishSubtotal + totalFlatTaxed + totalPctTaxed))
    }

    private static func calculateTotalFlatUntaxed(fees: PNOrderFees?) -> Float {
        return fees?.untaxedFlatFees?.reduce(0.0, { $0 + ($1.value ?? 0.0) }) ?? 0.0
    }

    private static func calculateTotalFlatTaxed(fees: PNOrderFees?) -> Float {
        return fees?.taxedFlatFees?.reduce(0.0, { $0 + ($1.value ?? 0.0) }) ?? 0.0
    }

    private static func calculateTotalPctTaxed(fees: PNOrderFees?, dishSubtotal: Float) -> Float {
        return fees?.taxedPctFees?.reduce(0.0, { $0 + (($1.value ?? 0.0) * dishSubtotal) }) ?? 0.0
    }

    private static func calculateTotalPctUntaxed(fees: PNOrderFees?, dishSubtotal: Float) -> Float {
        return fees?.untaxedPctFees?.reduce(0.0, { $0 + (($1.value ?? 0.0) * dishSubtotal) }) ?? 0.0
    }
}
