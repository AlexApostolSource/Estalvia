//
//  Registrations.swift
//  Estalvia
//
//  Created by Alex.personal on 16/11/25.
//

import SwiftData
import SwiftInject

extension InjectedValues {
	var persistentContainer: ModelContext {
		get {Self[ModelContextKey.self]}
		set {Self[ModelContextKey.self] = newValue}
	}
}

private enum ModelContextKey: InjectionKey {
	typealias Value = ModelContext

	nonisolated(unsafe) static var currentValue: ModelContext = {
		fatalError("ModelContext no registrado. Llama a Dependencies.register() antes de usarlo.")
	}()
}
