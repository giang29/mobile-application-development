//
//  HomeViewController.swift
//  lab1
//
//  Created by Giang Pham on 21/03/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    static func storyboardInstance() -> HomeViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? HomeViewController
    }
    
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var steper: UIStepper!
    
    @IBAction func decreasedClicked(_ sender: UIButton) {
        steper.value =  steper.value - steper.stepValue
        value.text = "\(steper.value)"
    }
    
    @IBAction func increaseClicked(_ sender: UIButton) {
        steper.value =  steper.value + steper.stepValue
        value.text = "\(steper.value)"
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        value.text = "\(steper.value)"
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let roundedValue = sender.value.rounded(.down)
        sender.setValue(roundedValue, animated: true)
        steper.stepValue = Double(roundedValue)
    }
    
    override func viewDidLoad() {
        value.text = "\(steper.value)"
    }
}
