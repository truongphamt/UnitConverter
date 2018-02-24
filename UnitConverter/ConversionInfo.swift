//
//  ConversionInfo.swift
//  UnitConverter
//
//  Created by Truong Pham on 2/23/18.
//  Copyright © 2018 Truong Pham. All rights reserved.
//

import UIKit

class ConversionInfo: NSObject {
    var type = ""
    var fromUnit = ""
    var toUnit = ""
    var conversionFactor = 0.0
    
    override init() {}
    
    init(type: String, fromUnit: String, toUnit: String, conversionFactor: Double) {
        self.type = type
        self.fromUnit = fromUnit
        self.toUnit = toUnit
        self.conversionFactor = conversionFactor
    }
}
