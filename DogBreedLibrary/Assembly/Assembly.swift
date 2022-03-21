//
//  Router.swift
//  DogBreedLibrary
//
//  Created by Daria Ten on 11.02.2022.
//

import UIKit

final class Assembly {
	
	func createBreedController() -> BreedViewController {
		let networking = Networking()
		let service = ApiService(networking: networking)
		let presenter = BreedPresenter(apiService: service)
		let router = Router(assembly: self)
		let breedVC = BreedViewController(presenter: presenter, router: router)
		presenter.delegate = breedVC
		
		return breedVC
	}
	
	func createImageViewController(for breed: String) -> ImageViewController {
		let networking = Networking()
		let service = ApiService(networking: networking)
		let presenter = ImagePresenter(apiService: service)
		let router = Router(assembly: self)
		let imageVC = ImageViewController(presenter: presenter,
										  router: router,
										  breed: breed)
		presenter.delegate = imageVC
		
		return imageVC
	}
}
