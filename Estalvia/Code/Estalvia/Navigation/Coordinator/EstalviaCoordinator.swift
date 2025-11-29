//
//  EstalviaCoordinator.swift
//  Estalvia
//
//  Created by Alex.personal on 29/11/25.
//

import UIKit

@MainActor
protocol EstalviaCoordinatorProtocol {
	var navigationController: UINavigationController { get }
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
	var navigationController: UINavigationController

	enum State {
		case initial
	}

	init(
		childCoordinators: [any EstalviaCoordinatorProtocol] = [],
		parentCoordinator: (any EstalviaCoordinatorProtocol)? = nil,
		navigationController: UINavigationController
	) {
		self.childCoordinators = childCoordinators
		self.parentCoordinator = parentCoordinator
		self.navigationController = navigationController
	}

	func start() {
		showTabBar()
	}

	private func showTabBar() {
		let tabar = MainTabBarFactory.createMainTabbar()
		navigationController.setViewControllers([tabar], animated: false)
	}
}
