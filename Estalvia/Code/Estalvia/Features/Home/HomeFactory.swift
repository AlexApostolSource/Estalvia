//
//  Factory.swift
//  Estalvia
//
//  Created by Alex.personal on 15/11/25.
//
import SwiftData
import SwiftInject
import SwiftPersistance

struct HomeFactory {
	static func makeAddExpenseView() -> HomeViewAddExpenseView {
		let modelContext: ModelContext = DependencyContainer.resolve(ModelContextKey.self)
		let localDataSourceProvider = SwiftPersistSwiftDataProvider(context: modelContext)
		let repo = HomeRepository(localDataSourceProvider: localDataSourceProvider)
		let useCase = HomeSaveExpanseUseCase(repository: repo)
		let viewModel = HomeAddExpenseViewModel(useCase: useCase)
		let view = HomeViewAddExpenseView(viewModel: viewModel)
		return view
	}
}
