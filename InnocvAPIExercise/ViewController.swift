//
//  ViewController.swift
//  InnocvAPIExercise
//
//  Created by Rick Larios on 28/8/22.
//

import UIKit

class ViewController: UIViewController {
	
	// MARK: - Dependencies
	
	private var domainViewModel: [User] = []

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "API Exercise"
		
		activityIndicator.hidesWhenStopped = true
		activityIndicator.stopAnimating()
		
		tableView.dataSource = self
		tableView.delegate = self
		tableView.isHidden = true
		

		
	}

//	@IBAction func getUserbyIdAction(_ sender: Any) {
//
//		activityIndicator.startAnimating()
//
//		NetworkingProvider.shared.getUserById(id: 6498) { (user) in
//
//			self.activityIndicator.stopAnimating()
//
//		} failure: { error in
//
//			self.activityIndicator.stopAnimating()
//		}
//
//	}
	
	
	@IBAction func newUserAction(_ sender: Any) {
		
		
		func startNavigation() {
			self.present(AddUserViewController(), animated: true)
			self.modalPresentationStyle = .none
			}

		startNavigation()
		
		
	}
	
	
	@IBAction func getAllUsersAction(_ sender: Any) {
		
		activityIndicator.startAnimating()
		
		NetworkingProvider.shared.getUsers() { (users) in
				
				self.activityIndicator.stopAnimating()
				self.domainViewModel = users
				self.tableView.reloadData()
				self.tableView.isHidden = false
				
				print(self.domainViewModel)
				
			} failure: { (error) in
				
				self.activityIndicator.stopAnimating()
				print(error.debugDescription)
				
			}
		
	}
	
}

extension ViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return domainViewModel.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
		if cell == nil {
			cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
			
			cell?.accessoryType = .disclosureIndicator
		}
		
		
		cell!.textLabel?.text = domainViewModel[indexPath.row].name
		
		return cell!
	}
}

extension ViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let selectedId = domainViewModel[indexPath.row].id {
			print(selectedId)
		}
		
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
			
			
			let delete = UIContextualAction(
				style: .destructive,
				title: "Borrar",
				handler: { _, _, _  in
					print("Delete item at index \(indexPath.row)")
					
					if let selectedId = self.domainViewModel[indexPath.row].id {
						print(selectedId)
						
						NetworkingProvider.shared.deleteUser(id: selectedId) { response in
							
							print("Usuario con id: \(selectedId) eliminado correctamente")
							
							NetworkingProvider.shared.getUsers() { (users) in
									
									self.activityIndicator.stopAnimating()
									self.domainViewModel = users
									self.tableView.reloadData()
									self.tableView.isHidden = false
									
									print(self.domainViewModel)
									
								} failure: { (error) in
									
									self.activityIndicator.stopAnimating()
									print(error.debugDescription)
									
								}
							
						
							} failure: { error in
							self.activityIndicator.stopAnimating()
							print(error.debugDescription)
						
							}
							
							
						}
				}
			)
			
			
			delete.image = UIImage(named: "trash")
			delete.backgroundColor = UIColor(named: "custom-red")
			
			
			let configuration = UISwipeActionsConfiguration(actions: [delete])
			
			
			return configuration
		}
}
