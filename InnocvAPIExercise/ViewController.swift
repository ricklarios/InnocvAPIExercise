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
			self.modalPresentationStyle = .fullScreen
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

