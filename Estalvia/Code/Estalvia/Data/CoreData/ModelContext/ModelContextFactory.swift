//
//  ModelContextFactory.swift
//  Estalvia
//
//  Created by Alex.personal on 16/11/25.
//

import SwiftData

@MainActor
struct ModelContextFactory {
	static func create() throws -> ModelContext {
			let schema = Schema([
				EstalviaExpenseRemote.self
			])

			let configuration = ModelConfiguration(
				schema: schema,
				isStoredInMemoryOnly: false,
				allowsSave: true
			)

			let container = try ModelContainer(
				for: schema,
				configurations: [configuration]
			)

			return ModelContext(container)
	}
}

enum EstalviaError: Error {

}

enum EstalviaDataError: Error {
	case cannotDataBaseCreateModelContext(error: Error)
}
