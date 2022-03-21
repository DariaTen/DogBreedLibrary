//
//  BreedViewController.swift
//  DogBreedLibrary
//
//  Created by Daria Ten on 17.01.2022.
//

import UIKit

protocol BreedView: AnyObject {

	func didRecieveBreed(_ dogs: [String])

	func didRecieveError(_ error: Error)
}

final class BreedViewController: UIViewController {

	private lazy var tableView : UITableView = {
		let tableView = UITableView(frame: .zero)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(BreedCell.self,
						   forCellReuseIdentifier: BreedCell.reuseIdentifier)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.dataSource = self
		tableView.delegate = self

		return tableView
	}()

	private lazy var activityIndicator: UIActivityIndicatorView = {
		let activityIndicator = UIActivityIndicatorView()
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		activityIndicator.startAnimating()
		activityIndicator.hidesWhenStopped = true

		return activityIndicator
	}()

	private var dogs: [String] = []

	private let presenter: BreedPresenterProtocol
	private let router: RouterProtocol

	init(presenter: BreedPresenterProtocol,
		 router: RouterProtocol) {
		self.presenter = presenter
		self.router = router
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white
		setUpContraints()
		presenter.searchBreed()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationBar.topItem?.title = "Doggies"
	}

	// MARK: - SetUp View

	private func setUpContraints() {
		view.addSubview(tableView)
		view.addSubview(activityIndicator)

		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}
}

// MARK: - DogNameView

extension BreedViewController: BreedView {

	func didRecieveBreed(_ dogs: [String]) {
		self.dogs = dogs
		tableView.reloadData()
		activityIndicator.stopAnimating()
	}

	func didRecieveError(_ error: Error) {}
}

// MARK: - UITableViewDataSource

extension BreedViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		dogs.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: BreedCell.reuseIdentifier,
													   for: indexPath) as? BreedCell
		else { return UITableViewCell() }

		cell.dogBreed.text = dogs[indexPath.row]

		return cell
	}
}

// MARK: - UITableViewDelegate

extension BreedViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let dog = dogs[indexPath.row]
		router.showImageController(from: self, requestedBreed: dog)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
