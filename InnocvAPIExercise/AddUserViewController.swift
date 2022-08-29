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
	
	override func viewDidLoad() {
        super.viewDidLoad()

		nameTextField.delegate = self
    }


    
	@IBAction func textFieldAction(_ sender: Any) {
		
		
	}
	
	@IBAction func submitAction(_ sender: Any) {
	}
}

extension AddUserViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		nameTextField.resignFirstResponder()
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		nameField = nameTextField.text!
	}
}
