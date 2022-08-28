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
	let kStatusCode = 200...299
	
	private let kBaseURL = "https://hello-world.innocv.com/api/"
	
	func getUserById(id: Int, success: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error?) -> ()) {
		
		let url = "\(kBaseURL)User/\(id)"
		
		
		AF.request(url, method: .get).validate(statusCode: kStatusCode).responseDecodable (of: User.self, decoder: DateDecoder()) { response in
			
			if let user = response.value {
				success(user)
			} else {
				failure(response.error)
			}
		}
	}
	
	func getUsers(success: @escaping (_ users: [User]) -> (), failure: @escaping (_ error: Error?) -> ()) {
		
		let url = "\(kBaseURL)User"
		
		AF.request(url, method: .get).validate(statusCode: kStatusCode).responseDecodable (of: [User].self, decoder: DateDecoder()) { response in
			
			if let users = response.value {
				success(users)
			} else {
				failure(response.error)
			}
			
		}
		
		
	}
}
