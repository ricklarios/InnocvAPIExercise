//
//  EditUserViewController.swift
//  InnocvAPIExercise
//
//  Created by Rick Larios on 30/8/22.
//

import UIKit

class EditUserViewController: UIViewController {
	
	var titulo: String?

	@IBOutlet weak var testLabell: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		if let myTitulo = titulo {
			testLabell.text = myTitulo
		} else {
			print("llegamos hasta aquí")
		}
    }


    

}
