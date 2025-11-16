//
//  Dependencies+ModelContext.swift
//  Estalvia
//
//  Created by Alex.personal on 16/11/25.
//
import SwiftData
import SwiftInject

extension DependenciesManager {
	static func registerModelContext() {
		do {
			let modelContext: ModelContext = try ModelContextFactory.create()
			DependencyContainer.register(\.persistentContainer, modelContext)
		} catch {
			print(error)
		}
	}
}
