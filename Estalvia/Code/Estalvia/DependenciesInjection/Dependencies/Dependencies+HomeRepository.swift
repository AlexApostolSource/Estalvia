//
//  Dependencies+HomeRepository.swift
//  Estalvia
//
//  Created by Alex.personal on 23/11/25.
//
import SwiftInject

extension DependenciesManager {
	static func registerHomeRepository() {
		let repo = HomeFactory.createRepository()
		DependencyContainer.register(HomeRepositoryKey.self, repo)
	}
}
