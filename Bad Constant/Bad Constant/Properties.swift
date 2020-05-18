//
//  Properties.swift
//  Bad Constant
//
//  Created by Nikolai Faustov on 18.05.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import Foundation

struct CutPropeties {
    let cutPrice = 10
    let capsulationPrice = 15
    let extensionPrice = 25
    
    var summaryCutPrice: Int {
        return cutPrice + capsulationPrice + extensionPrice
    }
    
    let cutPaymentProportion = 0.5
    let capsulationPaymentProportion = 0.4
    let extensionPaymentProportion = 0.5
}

struct ExtProperties {
    let extensionPayment = 12.5
}
