//
//  Factory.swift
//  Estalvia
//
//  Created by Alex.personal on 15/11/25.
//
import EstalviaDesignSystem
import Foundation
import SwiftData
import SwiftInject
import SwiftPersistance

struct HomeFactory {
	static func makeAddExpenseView(onSaved: (() -> Void)? = nil ) -> HomeViewAddExpenseView {
		let repo: HomeRepositoryProtocol = DependencyContainer.resolve(HomeRepositoryKey.self)
		let useCase = HomeSaveExpanseUseCase(repository: repo)
		let viewModel = HomeAddExpenseViewModel(useCase: useCase)
		let view = HomeViewAddExpenseView(viewModel: viewModel, onSaved: onSaved)
		return view
	}

	static func makeAddExpenseChildView(
		expense: EstalviaExpense,
		children: [EstalviaExpense],
		onSaved: (() -> Void)? = nil
	) -> AddExpenseChildView {
		let repo: HomeRepositoryProtocol = DependencyContainer.resolve(HomeRepositoryKey.self)
		let useCase = HomeSaveExpanseUseCase(repository: repo)
		let getExpenseUseCase: HomeGetExpenseUseCaseProtocol = HomeGetExpenseUseCase(repository: repo)
		let viewModel = AddExpenseChildViewModel(expense: expense, useCase: useCase, getExpensesUseCase: getExpenseUseCase, children: children)
		let view = AddExpenseChildView(viewModel: viewModel, onSaved: onSaved)
		return view
	}

	static func makeExpenseChildListView(from expense: EstalviaExpense, coordinatorOutput: HomeNavigationOutputs) -> ExpenseChildsView {
		let repo: HomeRepositoryProtocol = DependencyContainer.resolve(HomeRepositoryKey.self)
		let useCase: HomeUpdateExpenseUseCaseProtocol =  HomeUpdateExpenseUseCase(repo: repo)
		let getExpenseUseCase: HomeGetExpenseUseCaseProtocol = HomeGetExpenseUseCase(repository: repo)
		let viewModel = ExpenseChildsViewModel(
			expense: expense,
			useCase: useCase,
			getExpensesUseCase: getExpenseUseCase,
			navigationOutput: coordinatorOutput
		)
		let view = ExpenseChildsView(viewModel: viewModel)
		return view
	}

	static func makeExpenseListView(from expense: EstalviaExpense, tapAction: (() -> Void)? = nil) -> EstalviaExpenseTypeCell {
		EstalviaExpenseTypeCell(
			config: EstalviaExpenseTypeCellConfig(
				title: expense.name,
				amount: expense.amount.formatted(),
				description: expense.date.estalviaStyle,
				tapAction: tapAction
			)
		)
	}

	static func createHomeView(navigationOutput: HomeNavigationOutputs) -> HomeView {
		let repo: HomeRepositoryProtocol = DependencyContainer.resolve(HomeRepositoryKey.self)
		let useCase = HomeGetExpenseUseCase(repository: repo)
		let deleteExpenseUseCase = HomeDeleteExpenseUseCase(repository: repo)
		let viewModel = HomeViewModel(useCase: useCase, deleteExpenseUseCase: deleteExpenseUseCase, navigationOutput: navigationOutput)
		let view = HomeView(viewModel: viewModel)
		return view
	}

	static func createRepository() -> HomeRepository {
		let modelContext: ModelContext = DependencyContainer.resolve(ModelContextKey.self)
		let localDataSourceProvider = SwiftPersistSwiftDataProvider(context: modelContext)
		return HomeRepository(localDataSourceProvider: localDataSourceProvider)
	}
}
