//
//  AddUserViewController.swift
//  InnocvAPIExercise
//
//  Created by Rick Larios on 29/8/22.
//

import UIKit

class AddUserViewController: UIViewController {
	
	private var nameField: String? = ""
	
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var dateSelector: UIDatePicker!
	@IBOutlet weak var submitButton: UIButton!
	@IBOutlet weak var statusLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		statusLabel.text = ""
		nameTextField?.delegate = self
    }


    
	@IBAction func textFieldAction(_ sender: Any) {
		
		
	}
	
	@IBAction func submitAction(_ sender: Any) {
		
		let rawDate = dateSelector.date
		print(rawDate)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		let inputDate = dateFormatter.string(from: rawDate)
		// "yyyy-MM-ddTHH:mm:ss"
		if let inputName = nameTextField.text {
			let newUser = NewUser(name: inputName,
								  birthdate: inputDate, id: 0)
			
			NetworkingProvider.shared.addUser(user: newUser) { (response) in
				
				self.statusLabel.text = "User created successfully"

			} failure: { error in
				self.statusLabel.text = error.debugDescription
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
