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
		case showAddExpenseView(onSaved: (() -> Void)? = nil)
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
		loop(to: currentState)
	}

	func loop(to state: State) {
		switch state {
		case .initial:
			buildHome()
		case .showAddExpenseView(let onSaved):
			showAddExpenseView(onSaved: onSaved)
		}
	}

	private func buildHome() {
		let homeView = HomeFactory.createHomeView(coordinator: self)
		let hostVC = UIHostingController(rootView: homeView)
		navigationController.setViewControllers([hostVC], animated: false)
	}

	private func showAddExpenseView(onSaved: (() -> Void)? = nil) {
		let addExpenseView = HomeFactory.makeAddExpenseView(onSaved: onSaved)
		let hostVC = UIHostingController(rootView: addExpenseView)
		hostVC.modalPresentationStyle = .pageSheet

		if let sheet = hostVC.sheetPresentationController {
			sheet.detents = [.medium()]              // equivalente a .presentationDetents([.medium])
			sheet.prefersGrabberVisible = true       // opcional, muestra el “tirador”
			sheet.prefersScrollingExpandsWhenScrolledToEdge = false
			sheet.largestUndimmedDetentIdentifier = .medium
		}
		navigationController.present(hostVC, animated: true)
	}
}
