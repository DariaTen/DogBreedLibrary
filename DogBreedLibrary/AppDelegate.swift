//
//  AppDelegate.swift
//  DogBreedLibrary
//
//  Created by Daria Ten on 17.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow()
		window?.makeKeyAndVisible()
		let assembly = Assembly()
		let navigationController = UINavigationController()
		let breedVC = assembly.createBreedController()
		navigationController.viewControllers = [breedVC]
		
		window?.rootViewController = navigationController
		
		return true
	}
}

