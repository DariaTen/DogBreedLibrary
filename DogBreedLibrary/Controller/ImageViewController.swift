//
//  ImageViewController.swift
//  DogBreedLibrary
//
//  Created by Daria Ten on 17.01.2022.
//

import UIKit

protocol ImageView: AnyObject {
	func updateImage(_ images: DogsImages)
}

final class ImageViewController: UIViewController {

	private lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .vertical

		let collectionVew = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		collectionVew.translatesAutoresizingMaskIntoConstraints = false
		collectionVew.dataSource = self
		collectionVew.delegate = self
		collectionVew.register(ImageCell.self,
							   forCellWithReuseIdentifier: ImageCell.reuseIdentifier)

		return collectionVew
	}()
	private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
	private let minimumItemSpacing: CGFloat = 1
	private let itemsInRow: CGFloat = 1

	private var dogsImages = [String]()
	
	private let breed: String
	private let presenter: ImagePresenterProtocol
	private let router: RouterProtocol


	init(presenter: ImagePresenterProtocol,
		 router: RouterProtocol,
		 breed: String) {
		self.presenter = presenter
		self.router = router
		self.breed = breed
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white
		setUpConstraint()
		presenter.loadImage(for: breed)

	}

	// MARK: - SetUp View

	private func setUpConstraint() {
		view.addSubview(collectionView)

		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
			collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

// MARK: - DogImageView

extension ImageViewController: ImageView {

	func updateImage(_ images: DogsImages) {
		dogsImages = images.message
		collectionView.reloadData()
	}
}

// MARK: - UICollectionViewDataSource

extension ImageViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dogsImages.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier,
															for: indexPath) as? ImageCell

		else { return UICollectionViewCell()}

		cell.updateDogImage(for: dogsImages[indexPath.row])

		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ImageViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let paddingSpace = sectionInsets.left + sectionInsets.right + minimumItemSpacing * (itemsInRow - 1)
		let avaliableWidth = collectionView.bounds.width - paddingSpace
		let widthPerItem = avaliableWidth / itemsInRow - 4
		return CGSize(width: widthPerItem, height: widthPerItem)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return sectionInsets
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return minimumItemSpacing
	}
}
