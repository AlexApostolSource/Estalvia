//
//  EstalviaCoordinator.swift
//  Estalvia
//
//  Created by Alex.personal on 29/11/25.
//

import SwiftUI
import UIKit

@MainActor
protocol EstalviaNavigationCoordinatorProtocol: EstalviaCoordinatorProtocol {
	var navigationController: UINavigationController { get }
}

@MainActor
protocol EstalviaCoordinatorProtocol {
	func start()
	var childCoordinators: [any EstalviaCoordinatorProtocol] { get }
	var parentCoordinator: (any EstalviaCoordinatorProtocol)? { get }
	associatedtype State
}

@MainActor
final class EstalviaCoordinator: EstalviaCoordinatorProtocol {
	var state: State = .initial
	var childCoordinators: [any EstalviaCoordinatorProtocol]
	var parentCoordinator: (any EstalviaCoordinatorProtocol)?
	private let window: UIWindow

	enum State {
		case initial
	}

	init(
		childCoordinators: [any EstalviaCoordinatorProtocol] = [],
		parentCoordinator: (any EstalviaCoordinatorProtocol)? = nil,
		window: UIWindow
	) {
		self.childCoordinators = childCoordinators
		self.parentCoordinator = parentCoordinator
		self.window = window
	}

	func start() {
		showTabBar()
	}

	private func showTabBar() {
		let homeNavController = UINavigationController()
		let homeCoordinator = HomeCoordinator(navigationController: homeNavController, parentCoordinator: self)
		childCoordinators.append(homeCoordinator)
		homeCoordinator.start()

		let tabbar = MainTabBarFactory.createMainTabbar(homeNavigationController: homeNavController)

		window.rootViewController = tabbar
	}
}
