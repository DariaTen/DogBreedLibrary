//
//  ApiServiceTests.swift
//  DogBreedLibraryTests
//
//  Created by Daria Ten on 21.03.2022.
//

import XCTest
@testable import DogBreedLibrary

final class DogApiServiceTests: XCTestCase {

	private var apiService: ApiService!
	private var networking: NetworkingMock!

	override func setUp() {
		super.setUp()
		networking = NetworkingMock()
		apiService = ApiService(networking: networking)
	}

	override func tearDown() {
		apiService = nil
		networking = nil
		super.tearDown()
	}

	func testWhenGetBreedCalledThanNetworkingCalled() {
		// Arrange
		let completion:(Result<Dogs, Error>) -> Void = { _ in }

		// Act
		apiService.getBreed(completion: completion)
		// Assert
		XCTAssertEqual(networking.performRequestCount, 1)
	}
}

final class NetworkingMock: NetworkingProtocol {
	var performRequestCount = 0

	func performRequest<Dogs>(url: URL, completion: @escaping (Result<Dogs, Error>) -> Void) where Dogs : Decodable {
		performRequestCount += 1
	}
}
