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
		case showAddExpenseChildView(
			children: [EstalviaExpense],
			expense: EstalviaExpense,
			onSaved: (() -> Void)? = nil
		)
		case showParentExpenseDetail(expense: EstalviaExpense)
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
		currentState = state
		switch state {
		case .initial:
			buildHome()
		case .showAddExpenseView(let onSaved):
			showAddExpenseView(onSaved: onSaved)
		case .showAddExpenseChildView(let children, let expense, let onSaved):
			showAddExpenseChildView(children: children, expense: expense, onSaved: onSaved)
		case .showParentExpenseDetail(let expense):
			showParentDetailView(expense: expense)
		}
	}

	private func buildHome() {
		let homeView = HomeFactory.createHomeView(navigationOutput: self)
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

	private func showAddExpenseChildView(children: [EstalviaExpense], expense: EstalviaExpense, onSaved: (() -> Void)?) {
		let addExpenseView = HomeFactory.makeAddExpenseChildView(expense: expense, children: children, onSaved: onSaved)
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

	private func showParentDetailView(expense: EstalviaExpense) {
		let view = HomeFactory.makeExpenseChildListView(from: expense, coordinatorOutput: self)
		let hostVC = UIHostingController(rootView: view)
		navigationController.pushViewController(hostVC, animated: true)
	}

	private func expenseChildList(expense: EstalviaExpense) -> some View {
		HomeFactory.makeExpenseListView(from: expense)
	}
}

extension HomeCoordinator: HomeNavigationOutputs {
	func showAddExpense(onSaved: (() -> Void)?) {
		self.loop(to: .showAddExpenseView(onSaved: onSaved))
	}

	func showAddExpenseChild(children: [EstalviaExpense], expense: EstalviaExpense, onSaved: (() -> Void)?) {
		self.loop(to: .showAddExpenseChildView(children: children, expense: expense, onSaved: onSaved))
	}

	func showParentExpenseDetail(expense: EstalviaExpense) {
		self.loop(to: .showParentExpenseDetail(expense: expense))
	}
}
