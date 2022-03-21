//
//  ImageCell.swift
//  DogBreedLibrary
//
//  Created by Daria Ten on 20.01.2022.
//

import UIKit

final class ImageCell: UICollectionViewCell {

	static let reuseIdentifier = "ImageCell"

	let image = UIImageView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white

		image.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(image)

		NSLayoutConstraint.activate([
			image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func updateDogImage(for image: String) {
			guard let dogImageUrl = URL(string: image) else { return }

			DispatchQueue.global().async {
				if let imageData = try? Data(contentsOf: dogImageUrl) {
					DispatchQueue.main.async {
						self.image.image = UIImage(data: imageData)
				}
			}
		}
	}
}

