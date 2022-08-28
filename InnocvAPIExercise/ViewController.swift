//
//  ViewController.swift
//  InnocvAPIExercise
//
//  Created by Rick Larios on 28/8/22.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		activityIndicator.hidesWhenStopped = true
		activityIndicator.stopAnimating()
		
	}

	@IBAction func getUserbyIdAction(_ sender: Any) {
		
		activityIndicator.startAnimating()
		
		NetworkingProvider.shared.getUserById(id: 6498) { (user) in
			
			self.activityIndicator.stopAnimating()
			
		} failure: { error in
			
			self.activityIndicator.stopAnimating()
		}

	}
	
}

