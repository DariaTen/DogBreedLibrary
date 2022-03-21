//
//  ImagePresenter.swift
//  DogBreedLibrary
//
//  Created by Daria Ten on 04.03.2022.
//

import Foundation
import UIKit

protocol ImagePresenterProtocol {
	func loadImage(for breed: String)
}

final class ImagePresenter: ImagePresenterProtocol {

	weak var delegate: ImageView?
	private let apiService: ApiServiceProtocol


	init(apiService: ApiServiceProtocol) {
		self.apiService = apiService
	}

	func loadImage(for breed: String) {
		apiService.getImage(requestedBreed: breed) { result in
			DispatchQueue.main.async {
				switch result {
				case.success(let successResult):
					self.delegate?.updateImage(successResult)
				case.failure(let error):
					print(error)
				}
			}
		}
	}
}

