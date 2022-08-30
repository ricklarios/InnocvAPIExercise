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
	private var userViewModel: User?
	
	// MARK: - Oulets
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	// MARK: - Methods
	private func refreshAllUsers() {
		NetworkingProvider.shared.getUsers() { (users) in
				self.activityIndicator.stopAnimating()
				self.domainViewModel = users
				self.tableView.reloadData()
			} failure: { (error) in
				self.activityIndicator.stopAnimating()
				print(error.debugDescription)
				
			}
	}
	
	// MARK: - View Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "API Exercise"
		activityIndicator.hidesWhenStopped = true
		activityIndicator.stopAnimating()
		tableView.dataSource = self
		tableView.delegate = self
		tableView.isHidden = true
		
	}
	
	// MARK: - Actions
	@IBAction func newUserAction(_ sender: Any) {
		self.present(AddUserViewController(), animated: true, completion: nil)
		self.modalPresentationStyle = .fullScreen
				
	}
		
	@IBAction func getAllUsersAction(_ sender: Any) {
		activityIndicator.startAnimating()
		refreshAllUsers()
		self.tableView.isHidden = false
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
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			guard let secondVC = storyboard.instantiateViewController(withIdentifier: "EditUserViewController") as? EditUserViewController else  {  return }
			secondVC.userId = selectedId
			self.present(secondVC, animated: true, completion: nil)
			self.modalPresentationStyle = .custom
			}
		}
				
		
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
			let delete = UIContextualAction(
				style: .destructive,
				title: "Borrar",
				handler: { _, _, _  in
					print("Delete item at index \(indexPath.row)")
					if let selectedId = self.domainViewModel[indexPath.row].id {
						NetworkingProvider.shared.deleteUser(id: selectedId) { response in
							print("Usuario con id: \(selectedId) eliminado correctamente")
							self.refreshAllUsers()
							self.tableView.isHidden = false
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
