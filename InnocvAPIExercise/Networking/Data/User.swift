//
//  User.swift
//  InnocvAPIExercise
//
//  Created by Rick Larios on 28/8/22.
//

import Foundation

//{
//	"name": "Alberto2",
//	"birthdate": "1998-06-08T00:00:00",
//	"id": 6498
//}

struct User: Decodable {
	
	let name: String?
	let birthdate: Date?
	let id: Int?
	
}


