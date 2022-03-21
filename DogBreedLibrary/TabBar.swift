//
//  TabBar.swift
//  PhotoLike
//
//  Created by Daria Ten on 17.01.2022.
//

import UIKit

final class TabBar: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .systemBackground
		UITabBar.appearance().barTintColor = .systemBackground
		tabBar.tintColor = .label
		setUpVC()
	}

	private func createNavController(for rootViewController: UIViewController,
									 title: String,
									 image: UIImage?) -> UIViewController {
		let navController = UINavigationController(rootViewController: rootViewController)
		navController.tabBarItem.title = title
		navController.tabBarItem.image = image
		navController.navigationBar.prefersLargeTitles = true
		rootViewController.navigationItem.title = title

		return navController
	}

	func setUpVC() {
		viewControllers = [
			createNavController(for: RandomViewController(), title: "Search", image: UIImage(systemName: "magnifyingglass")),
			createNavController(for: FavoriteViewController(), title: "Favorite", image: UIImage(systemName: "star"))
		]
	}
}
