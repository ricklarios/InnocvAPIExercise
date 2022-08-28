//
//  DateDecoder.swift
//  InnocvAPIExercise
//
//  Created by Rick Larios on 28/8/22.
//

import Foundation

final class DateDecoder: JSONDecoder {
	
	let dateFormatter = DateFormatter()
	
	override init() {
		super.init()
		// "2020-10-10T03:50:06.151+05:30"
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
		dateDecodingStrategy = .formatted(dateFormatter)
	}
	
}
