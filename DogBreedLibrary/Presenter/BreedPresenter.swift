//
//  BreedPresenter.swift
//  DogBreedLibrary
//
//  Created by Daria Ten on 21.02.2022.
//

import Foundation

protocol BreedPresenterProtocol {
	func searchBreed()
}

final class BreedPresenter: BreedPresenterProtocol {

	weak var delegate : BreedView?
	private let apiService : ApiServiceProtocol

	init(apiService: ApiServiceProtocol) {
		self.apiService = apiService
	}

	func searchBreed() {
		apiService.getBreed { [weak self] (result: Result<Dogs, Error>) in
			guard let self = self else { return }
			DispatchQueue.main.async {
				switch result {
				case .success(let successResult):
					let breeds = self.getBreed(successResult)
					self.delegate?.didRecieveBreed(breeds)
				case .failure(let error):
					self.delegate?.didRecieveError(error)
				}
			}
		}
	}

	private func getBreed(_ dogs: Dogs) -> [String] {
		var dogsNames = [String]()
		for (key, _) in dogs.message {
			dogsNames.append(key)
		}
		return dogsNames.sorted()
	}
}
