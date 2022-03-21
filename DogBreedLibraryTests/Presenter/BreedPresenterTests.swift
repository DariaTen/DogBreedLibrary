//
//  BreedPresenterTests.swift
//  DogBreedLibraryTests
//
//  Created by Daria Ten on 21.03.2022.
//

import XCTest
@testable import DogBreedLibrary

final class BreedPresenterTests: XCTestCase {

	private var presenter: BreedPresenter!
	private var apiService: ApiServiceMock!

	override func setUp() {
		super.setUp()
		apiService = ApiServiceMock()
		presenter = BreedPresenter(apiService: apiService)
	}

	override func tearDown() {
		apiService = nil
		presenter = nil
		super.tearDown()
	}

	func testWhenBreedPresenterCalledThanApiServiceCalled() {
		// Arrange
		// Act
		presenter.searchBreed()
		// Assert
		XCTAssertEqual(apiService.getBreedCount, 1)
	}
}

final class ApiServiceMock: ApiServiceProtocol {

	var getBreedCount = 0

	func getBreed(completion: @escaping (Result<Dogs, Error>) -> Void ) {
		getBreedCount += 1
	}

	var getImageCount = 0

	func getImage(requestedBreed: String, completion: @escaping (Result<DogsImages, Error>) -> Void) {
		getImageCount += 1
	}
}
