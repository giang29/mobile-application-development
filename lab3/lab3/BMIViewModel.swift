//
//  BMIViewModel.swift
//  lab3
//
//  Created by Giang Pham on 23/03/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import Foundation

class BMIViewModel {
    
    let calculationLocalDataStore: CalculationLocalDataSource
    
    init(calculationLocalDataStore: CalculationLocalDataSource) {
        self.calculationLocalDataStore = calculationLocalDataStore
    }
    
    let state = LiveData<State>()
    
    func calculateBMI(name: String, height: Int, weight: Double) {
        let bmi = weight * 10000 / Double(height * height)
        do {
            try calculationLocalDataStore.saveCalculation(Calculation(
                person: Person(name: name, height: height, weight: weight),
                bmi: bmi
            ))
            let calculations = calculationLocalDataStore.getCalculations()
            state.value = .success(bmi, calculations)
        } catch let error {
            state.value = .failed(error)
        }
    }
}

enum State {
    case failed(Error)
    case success(Double, [Calculation])
}
