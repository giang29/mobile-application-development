//
//  BMIViewController.swift
//  lab3
//
//  Created by Giang Pham on 23/03/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import UIKit

class BMIViewController : UIViewController {
    static func storyboardInstance() -> BMIViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? BMIViewController
    }

    private let bmiViewModel = BMIViewModel(calculationLocalDataStore: CalculationLocalDataSourceImpl())
    private let heights = Array(20...240)
    private let weights = Array(stride(from: 1.5, to: 200.1, by: 0.1))
    private lazy var currentHeight: Int = heights[0]
    private lazy var currentWeight: Double = weights[0]
    private var histories = [Calculation]()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var heightPicker: UIPickerView!
    @IBOutlet weak var history: UITableView!
    @IBOutlet weak var bmiLabel: UILabel!
    override func viewDidLoad() {
        nameTextField.delegate = self
        weightPicker.delegate = self
        weightPicker.dataSource = self
        heightPicker.delegate = self
        heightPicker.dataSource = self
        hideKeyboard()
        history.dataSource = self
        bmiViewModel.state.observe(completionHandler: { state in
            self.render(state)
        })
    }
    
    private func render(_ state: State?) {
        guard let state = state else { return }
        switch state {
        case .success(let bmi, let calculations):
            bmiLabel.text = String(bmi)
            histories = calculations
            history.reloadData()
        default:
            return
        }
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        bmiViewModel.calculateBMI(name: nameTextField.text!, height: currentHeight, weight: currentWeight)
    }
}

extension BMIViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 2) {
            return heights.count
        } else {
            return weights.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 2) {
            return "\(heights[row]) cm"
        } else {
            return "\(NSString(format: "%.1f", weights[row])) kg"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameTextField.resignFirstResponder()
        if(pickerView.tag == 2) {
            currentHeight = heights[row]
        } else {
            currentWeight = weights[row]
        }
    }
}

extension BMIViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HistoryTableViewCell.self), for: indexPath) as? HistoryTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        let history = histories[indexPath.row]
        cell.nameLabel.text = history.person.name
        cell.bmiLabel.text = NSString(format: "%.1f", history.bmi) as String
        return cell
    }
}

extension BMIViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            let alertController = UIAlertController(title: "Alert", message: "Name must not be empty!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Understand", style: .default) { (action:UIAlertAction) in
                alertController.dismiss(animated: true, completion: nil)
                self.nameTextField.becomeFirstResponder()
            }
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
    }
}

extension UIViewController {
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
