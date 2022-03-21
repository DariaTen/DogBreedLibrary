//
//  ImagePresenterTests.swift
//  DogBreedLibraryTests
//
//  Created by Daria Ten on 21.03.2022.
//

import XCTest
@testable import DogBreedLibrary

final class ImagePresenterTests: XCTestCase {

	private var presenter: ImagePresenter!
	private var apiService: ApiServiceMock!

	override func setUp() {
		super.setUp()
		apiService = ApiServiceMock()
		presenter = ImagePresenter(apiService: apiService)
	}

	override func tearDown() {
		apiService = nil
		presenter = nil
		super.tearDown()
	}

	func testWhenImagePresenterCalledThanApiServiceCalled() {
		// Arrange
		// Act
		presenter.loadImage(for: "")
		// Assert
		XCTAssertEqual(apiService.getImageCount, 1)
	}
}

