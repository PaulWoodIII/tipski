//
//  SKProduct+LocalizedPrice.swift
//  Tipski
//
//  Created by Paul Wood on 10/20/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import Foundation
import StoreKit

extension SKProduct {
    var localizedPrice : String {
        get {
            let nf = NumberFormatter()
            nf.formatterBehavior = .behavior10_4
            nf.numberStyle = .currency
            nf.locale = priceLocale
            return nf.string(from: price)!
        }
    }
}
