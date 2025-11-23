//
//  Registrations.swift
//  Estalvia
//
//  Created by Alex.personal on 16/11/25.
//

import SwiftData
import SwiftInject

struct ModelContextKey: InjectionKey {
	typealias Value = ModelContext

	nonisolated(unsafe) static var currentValue: ModelContext = {
		fatalError("ModelContext not registered. Call Dependencies.register() before using any ModelContext.")
	}()
}
