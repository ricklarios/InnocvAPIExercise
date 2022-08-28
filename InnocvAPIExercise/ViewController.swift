//
//  ViewController.swift
//  InnocvAPIExercise
//
//  Created by Rick Larios on 28/8/22.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func getUserbyIdAction(_ sender: Any) {
		
		NetworkingProvider.shared.getUserById(id: 6498)
	}
	
}

