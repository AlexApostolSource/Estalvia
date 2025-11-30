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

	static func makeExpenseListView(from expense: EstalviaExpense) -> EstalviaExpenseTypeCell {
		EstalviaExpenseTypeCell(
			config: EstalviaExpenseTypeCellConfig(
				title: expense.name,
				amount: expense.amount.formatted(),
				description: expense.date.description
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
