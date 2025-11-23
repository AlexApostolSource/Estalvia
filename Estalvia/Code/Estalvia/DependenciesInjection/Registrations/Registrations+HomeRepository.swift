//
//  Registrations+HomeRepository.swift
//  Estalvia
//
//  Created by Alex.personal on 23/11/25.
//

import SwiftData
import SwiftInject

struct HomeRepositoryKey: InjectionKey {
	typealias Value = HomeRepositoryProtocol

	nonisolated(unsafe) static var currentValue: HomeRepositoryProtocol = {
		fatalError("ModelContext not registered. Call Dependencies.register() before using any ModelContext.")
	}()
}
