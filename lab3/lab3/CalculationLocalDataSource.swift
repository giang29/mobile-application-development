//
//  CalculationLocalDataSource.swift
//  lab3
//
//  Created by Giang Pham on 23/03/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import Foundation

protocol CalculationLocalDataSource {
    func saveCalculation(_ calculation: Calculation)
    func getCalculations()-> [Calculation]
}

class CalculationLocalDataSourceImpl: CalculationLocalDataSource {
    private var calculations = [Calculation]()
    func saveCalculation(_ calculation: Calculation) {
        calculations.insert(calculation, at: 0)
    }
    
    func getCalculations()-> [Calculation] {
        return calculations
    }
}
