//
//  ModelContextFactory.swift
//  Estalvia
//
//  Created by Alex.personal on 16/11/25.
//

import SwiftData

struct ModelContextFactory {
	static func create() throws -> ModelContext {
		let container = try ModelContainer(configurations: .init())
		return ModelContext(container)
	}
}

enum EstalviaError: Error {

}

enum EstalviaDataError: Error {
	case cannotDataBaseCreateModelContext(error: Error)
}
