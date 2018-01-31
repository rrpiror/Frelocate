//
//  PurchaseManager.swift
//  Frelocate
//
//  Created by Rob Prior on 28/01/2018.
//  Copyright © 2018 Rob Prior. All rights reserved.
//

typealias completionHandler = (_ success: Bool) -> ()

import Foundation
import StoreKit

class PurchaseManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static let instance = PurchaseManager()
    
    let IAP_REMOVE_ADS = "com.frelocate.frelocate.removeAds"
    
    var productsRequest: SKProductsRequest!
    var products = [SKProduct]()
    var transactionComplete: completionHandler?
    
    func fetchProducts() {
        let productIds = NSSet(object: IAP_REMOVE_ADS) as! Set<String>
        productsRequest = SKProductsRequest(productIdentifiers: productIds)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    func purchaseRemoveAds(onComplete: @escaping completionHandler) {
        if SKPaymentQueue.canMakePayments() && products.count > 0 {
            transactionComplete = onComplete
            let removeAdsProduct = products[0]
            let payment = SKPayment(product: removeAdsProduct)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            
        } else {
            onComplete(false)
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        if response.products.count > 0 {
            print("ROB: \(response.products.debugDescription)")
            products = response.products
        } else {
            print("ROB: YOUR ERROR IS HERE")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                if transaction.payment.productIdentifier == IAP_REMOVE_ADS {
                    UserDefaults.standard.set(true, forKey: IAP_REMOVE_ADS)
                    transactionComplete?(true)
                }
                break
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                transactionComplete?(false)
                break
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                transactionComplete?(true)
                break
            default:
                transactionComplete?(false)
                break
            }
        }
    }
}
