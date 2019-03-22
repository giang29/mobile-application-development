//
//  HomeViewController.swift
//  lab2
//
//  Created by Giang Pham on 21/03/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import UIKit

class HomeViewController : UIViewController {
    static func storyboardInstance() -> HomeViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? HomeViewController
    }
    
    var meal: Meal!
    
    override func viewDidLoad() {
        nameTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.backBarButtonItem
            = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped(sender:)))
        navigationController?.navigationBar.topItem?.rightBarButtonItem
            = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveMeal(sender:)))
        title = "New meal"
    }
    
    @objc func cancelTapped(sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    @objc func saveMeal(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToMealList", sender: self)
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let name = nameTextField.text {
            meal = Meal(name: name, photo: photoImageView.image, rating: ratingControl.rating)
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

extension HomeViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}

extension HomeViewController: UINavigationControllerDelegate {
}
