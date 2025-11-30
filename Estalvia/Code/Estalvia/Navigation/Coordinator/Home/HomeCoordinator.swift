//
//  HomeCoordinator.swift
//  Estalvia
//
//  Created by Alex.personal on 30/11/25.
//

import SwiftUI
import UIKit

final class HomeCoordinator: EstalviaNavigationCoordinatorProtocol {
	enum State {
		case initial
	}

	private var currentState: State = .initial

	var navigationController: UINavigationController

	var childCoordinators: [any EstalviaCoordinatorProtocol]

	var parentCoordinator: (any EstalviaCoordinatorProtocol)?

	init(
		currentState: State = .initial,
		navigationController: UINavigationController,
		childCoordinators: [any EstalviaCoordinatorProtocol] = [],
		parentCoordinator: (any EstalviaCoordinatorProtocol)? = nil
	) {
		self.currentState = currentState
		self.navigationController = navigationController
		self.childCoordinators = childCoordinators
		self.parentCoordinator = parentCoordinator
	}

	func start() {
		buildHome()
	}

	private func buildHome() {
		let homeView = HomeFactory.createHomeView()
		let hostVC = UIHostingController(rootView: homeView)
		navigationController.setViewControllers([hostVC], animated: false)
	}
}
