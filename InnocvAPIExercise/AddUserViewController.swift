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
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
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
			
			NetworkingProvider.shared.addUser(user: newUser) { response in
				
				print("OK!!!!")
				let alertController = UIAlertController(title: "ok", message: "User created successfully", preferredStyle: .alert)
				alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
					self.dismiss(animated: true)
				})
				alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
				
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
