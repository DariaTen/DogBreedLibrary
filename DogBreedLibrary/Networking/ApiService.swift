//
//  ApiService.swift
//  DogBreedLibrary
//
//  Created by Daria Ten on 11.02.2022.
//

import Foundation

protocol ApiServiceProtocol {
	
	func getBreed(completion: @escaping (Result<Dogs, Error>) -> Void )
	
	func getImage(requestedBreed: String, completion: @escaping (Result<DogsImages, Error>) -> Void)
}

final class ApiService: ApiServiceProtocol {
	
	enum ApiServiceError: Error {
		case wrongUrl
	}
	
	private let networking: NetworkingProtocol
	
	init(networking: NetworkingProtocol) {
		self.networking = networking
	}
	
	func getBreed(completion: @escaping (Result<Dogs, Error>) -> Void ) {
		
		let url = URL(string: "https://dog.ceo/api/breeds/list/all")
		guard let url = url else {
			completion(.failure(ApiServiceError.wrongUrl))
			return
		}
		networking.performRequest(url: url, completion: completion)
	}
	
	func getImage(requestedBreed: String, completion: @escaping (Result<DogsImages, Error>) -> Void) {
		
		let url = URL(string: "https://dog.ceo/api/breed/\(requestedBreed)/images")
		guard let url = url else {
			completion(.failure(ApiServiceError.wrongUrl))
			return
		}
		networking.performRequest(url: url, completion: completion)
	}
}
