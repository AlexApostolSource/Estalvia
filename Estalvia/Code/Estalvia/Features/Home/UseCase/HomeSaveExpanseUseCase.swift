//
//  HomeSaveExpanseUseCase.swift
//  Estalvia
//
//  Created by Alex.personal on 15/11/25.
//

import Foundation

public protocol HomeSaveExpanseUseCaseProtocol {
	func save(entity: EstalviaExpense) throws
}

public struct HomeSaveExpanseUseCase: HomeSaveExpanseUseCaseProtocol {
	private let repository: HomeRepositoryProtocol

	public func save(entity: EstalviaExpense) throws {
		try repository.save(entity: entity)
	}
}
