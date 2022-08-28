//
//  NetworkingProvider.swift
//  InnocvAPIExercise
//
//  Created by Rick Larios on 28/8/22.
//

import Foundation
import Alamofire

final class NetworkingProvider {
	
	static let shared = NetworkingProvider()
	
	private let kBaseURL = "https://hello-world.innocv.com/api/"
	
	func getUserById(id: Int) {
		
		let url = "\(kBaseURL)User/\(id)"
		let kStatusCode = 200...299
		
		AF.request(url, method: .get).validate(statusCode: kStatusCode).responseDecodable (of: User.self) { response in
			
			if let user = response.value {
				print(user)
			} else {
				print(response.error?.responseCode ?? "No error")
			}
		}
	}
}
