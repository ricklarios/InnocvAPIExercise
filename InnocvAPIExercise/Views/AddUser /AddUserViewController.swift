//
//  AddUserViewController.swift
//  InnocvAPIExercise
//
//  Created by Rick Larios on 29/8/22.
//

import UIKit

class AddUserViewController: UIViewController {
	
	
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var dateSelector: UIDatePicker!
	@IBOutlet weak var submitButton: UIButton!	
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		nameTextField?.delegate = self
		
		activityIndicator.hidesWhenStopped = true
		activityIndicator.stopAnimating()
    }
	
	@IBAction func submitAction(_ sender: Any) {
		
		activityIndicator.startAnimating()
		
		let rawDate = dateSelector.date
		print(rawDate)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		let inputDate = dateFormatter.string(from: rawDate)
		
		if let inputName = nameTextField.text {
			let newUser = NewUser(name: inputName,
								  birthdate: inputDate, id: 0)
			
			NetworkingProvider.shared.addUser(user: newUser) { response in
				
				self.activityIndicator.stopAnimating()
				print("OK!!!!")
				let alertController = UIAlertController(title: "Success", message: "User created successfully", preferredStyle: .alert)
				alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
					self.dismiss(animated: true)
				})
				alertController.addAction(UIAlertAction(title: "Add another user", style: .cancel) { _ in
					self.nameTextField.text = ""
				})
				
				self.present(alertController, animated: true, completion: nil)
				

				} failure: { error in
				
					print(error!)
				}
			
		}
		
		

		
	}
}

extension AddUserViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		nameTextField.resignFirstResponder()
		
	}
}
