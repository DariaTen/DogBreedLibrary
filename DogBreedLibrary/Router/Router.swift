//
//  Router.swift
//  DogBreedLibrary
//
//  Created by Daria Ten on 02.11.2021.
//

import UIKit

protocol RouterProtocol {

	func showImageController(from controller: UIViewController, requestedBreed: String)
}

final class Router: RouterProtocol {

	private let assembly: Assembly

	init(assembly: Assembly) {
		self.assembly = assembly
	}

	func showImageController(from controller: UIViewController, requestedBreed: String) {
		guard let navigationController = controller.navigationController else { return }
		let imageController = assembly.createImageViewController(for: requestedBreed)
		navigationController.pushViewController(imageController, animated: true)
	}
}
