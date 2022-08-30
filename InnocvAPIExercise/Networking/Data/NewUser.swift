//
//  NewUser.swift
//  InnocvAPIExercise
//
//  Created by Rick Larios on 29/8/22.
//

import Foundation

struct NewUser: Encodable {
	let name: String?
	let birthdate: String?
	let id: Int?
}
