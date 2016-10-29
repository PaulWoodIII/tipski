//
//  PurchaseManager.swift
//  Tipski
//
//  Created by Paul Wood on 10/20/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import Foundation
import StoreKit

// Define identifier
let PurchaseManagerProductsUpdatedNotification = Notification.Name("PurchaseManagerProductsUpdatedNotification")
let PurchaseManagerTransactionFailedNotification = Notification.Name("PurchaseManagerTransactionFailedNotification")
let PurchaseManagerTransactionSucceededNotification = Notification.Name("PurchaseManagerTransactionSucceededNotification")

let FullUnlock = "ski.tip.full.unlock.1"
let FullUnlockChangedNotification = Notification.Name("ski.tip.full.unlock.1")


class PurchaseManager : NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static let shared = PurchaseManager()

    var fullUnlockProduct : SKProduct?
    var fullUnlockRequest : SKProductsRequest!
    
    func requestProduct(){
        let productIdentifiers : Set<String> = [FullUnlock];
        fullUnlockRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        fullUnlockRequest.delegate = self
        fullUnlockRequest.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let product = response.products.first {
            fullUnlockProduct = product
            NotificationCenter.default.post(name: PurchaseManagerProductsUpdatedNotification, object: self)
        }
        if response.invalidProductIdentifiers.count > 0 {
            print(response.invalidProductIdentifiers)
        }
    }
    
    // public methods
    func loadStore(){
        SKPaymentQueue.default().add(self)
        requestProduct()
    }
    
    func unloadStore(){
        SKPaymentQueue.default().remove(self)
    }
    
    func canMakePurchases() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    func purchaseFullUpgrade() {
        guard let fullUnlockProduct = fullUnlockProduct else {
            print("no product to pay for")
            return
        }
        let payment = SKPayment(product: fullUnlockProduct)
        SKPaymentQueue.default().add(payment)
    }
    
    func restorePastTransactions(){
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func recordTransaction(transaction : SKPaymentTransaction){
        if transaction.payment.productIdentifier == FullUnlock {
            // save the transaction receipt to disk
            // This uses UserDefaults
            UserDefaults.standard.set(true, forKey: FullUnlock)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: FullUnlockChangedNotification, object: self, userInfo: nil)
        }
    }
    
    func finishTransaction(transaction: SKPaymentTransaction, wasSuccessful : Bool){
        
        let userInfo = Dictionary(dictionaryLiteral: ("transaction",transaction))
        SKPaymentQueue.default().finishTransaction(transaction)
        
        if wasSuccessful {
            NotificationCenter.default.post(name: PurchaseManagerTransactionSucceededNotification, object: self, userInfo: userInfo)
        }
        else {
            NotificationCenter.default.post(name: PurchaseManagerTransactionFailedNotification, object: self, userInfo: userInfo)
        }
        
    }
    
    func completeTransaction(transaction : SKPaymentTransaction){
        recordTransaction(transaction: transaction)
        finishTransaction(transaction: transaction, wasSuccessful: true)
    }
    
    func failedTransation(transaction : SKPaymentTransaction) {
        if let _ = transaction.error {
            //Only do this if NOT canceled
            finishTransaction(transaction: transaction, wasSuccessful: false)
        }
        else {
            SKPaymentQueue.default().finishTransaction(transaction)
        }
    }
    
    func restoreTransaction(transaction : SKPaymentTransaction) {
        recordTransaction(transaction: transaction)
        finishTransaction(transaction: transaction, wasSuccessful: true)
    }
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]){
        for transaction in transactions {
            print(transaction.transactionState.rawValue)
            switch transaction.transactionState {
            case .purchased:
                completeTransaction(transaction: transaction)
                
            case .failed:
                failedTransation(transaction: transaction)
                
            case .restored:
                restoreTransaction(transaction: transaction)
                
            default:
                break
                
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
    }
    
    public func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error){
        print(error)
        for transaction in queue.transactions {
            print(transaction.transactionState.rawValue)
            switch transaction.transactionState {
            case .failed:
                failedTransation(transaction: transaction)
            default:
                break
            }
        }
    }
    
    public func checkReceipts(){
        if let url = Bundle.main.appStoreReceiptURL {
            let receipt = NSData(contentsOf: url)
        }
    }
}
