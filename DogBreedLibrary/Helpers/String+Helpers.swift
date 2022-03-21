//
//  String+Helpers.swift
//  DogBreedLibrary
//
//  Created by Daria Ten on 18.03.2022.
//

extension String {
	func capitalizingFirstLetter() -> String {
		return prefix(1).capitalized + dropFirst()
	}

	mutating func capitalizeFirstLetter() {
		self = self.capitalizingFirstLetter()
	}
}
