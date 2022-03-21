//
//  BreedCell.swift
//  DogBreedLibrary
//
//  Created by Daria Ten on 20.01.2022.
//

import UIKit

final class BreedCell: UITableViewCell {

	static let reuseIdentifier = "NameCell"

	let dogBreed = UILabel()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		dogBreed.translatesAutoresizingMaskIntoConstraints = false
		dogBreed.font = UIFont.systemFont(ofSize: 20)

		contentView.addSubview(dogBreed)

		NSLayoutConstraint.activate([
			dogBreed.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
			dogBreed.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			dogBreed.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
			dogBreed.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
		])
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

