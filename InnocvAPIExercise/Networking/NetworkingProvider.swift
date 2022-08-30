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
	
	func addUser(user: NewUser, success: @escaping (_ response: String) -> (), failure: @escaping (_ error: Error?) -> ()) {
		
		let url = "\(kBaseURL)User"
		
		AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: kStatusCode).response { response in
			
			if let error = response.error {
							failure(error)
						} else {
							success("ok")
						}
						
		}
	}
	
	func updateUser(user: NewUser, success: @escaping (_ response: String) -> (), failure: @escaping (_ error: Error?) -> ()) {
		
		let url = "\(kBaseURL)User"
		
		
		
		AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: kStatusCode).response {
			response in
			
			if let error = response.error {
							failure(error)
						} else {
							success("ok")
						}
		}
	}
	
	func deleteUser(id: Int, success: @escaping (_ response: String) -> (), failure: @escaping (_ error: Error?) -> ()) {
			
			let url = "\(kBaseURL)User/\(id)"
			
			
		AF.request(url, method: .delete).validate(statusCode: kStatusCode).response { response in
				
				if let error = response.error {
					failure(error)
				} else {
					success("ok")
				}
			}
			
		}
}
