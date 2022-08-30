//
//  EditUserViewController.swift
//  InnocvAPIExercise
//
//  Created by Rick Larios on 30/8/22.
//

import UIKit

class EditUserViewController: UIViewController {

	
	var userId: Int?
	var selectedUser: User?
	@IBOutlet weak var testLabell: UILabel!
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var dateField: UIDatePicker!
	@IBOutlet weak var sumbitButton: UIButton!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.nameField.text = ""
		
		activityIndicator.hidesWhenStopped = true
		activityIndicator.startAnimating()
		
		if let selectedId = userId {
			NetworkingProvider.shared.getUserById(id: selectedId) { user in
				
				self.activityIndicator.stopAnimating()
				print("GetUser -> \(user)")
				
				self.testLabell.text = user.name
				self.nameField.text = user.name
				self.userId = user.id
				
				if let date = user.birthdate {
					self.dateField.date = date
				}
				
				} failure: { error in
					self.activityIndicator.stopAnimating()
					print(error.debugDescription)
				}
			
				
				
			}
			
		}
    

	@IBAction func submitAction(_ sender: Any) {
		
		activityIndicator.startAnimating()
		
		let newDate = dateField.date
		print(newDate)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		let inputDate = dateFormatter.string(from: newDate)
		
		if let inputName = nameField.text {
			let newUser = NewUser(name: inputName,
								  birthdate: inputDate, id: userId)
			print(newUser)
			NetworkingProvider.shared.updateUser(user: newUser) { response in
				
				self.activityIndicator.stopAnimating()
				print("OK!!!!")
				let alertController = UIAlertController(title: "Success", message: "User created successfully", preferredStyle: .alert)
				alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
					self.dismiss(animated: true)
				})
				alertController.addAction(UIAlertAction(title: "Add another user", style: .cancel) { _ in
					self.nameField.text = ""
				})
				
				self.present(alertController, animated: true, completion: nil)
				

				} failure: { error in
				
					print(error!)
				}
			
		}
		
	}
	
    

}