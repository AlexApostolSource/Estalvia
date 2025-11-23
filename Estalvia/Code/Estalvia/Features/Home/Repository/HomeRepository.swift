//
//  HomeRepository.swift
//  Estalvia
//
//  Created by Alex.personal on 9/11/25.
//

import SwiftPersistance

public protocol HomeRepositoryProtocol {
	func save(entity: EstalviaExpense) throws
	func getExpenses() throws -> [EstalviaExpense]
}

public struct HomeRepository: HomeRepositoryProtocol {
	private let localDataSourceProvider: SwiftPersistanceSwiftData

	init(localDataSourceProvider: SwiftPersistanceSwiftData) {
		self.localDataSourceProvider = localDataSourceProvider
	}

	public func save(entity: EstalviaExpense) throws {
		try localDataSourceProvider.save(entity: ExpenseMapper.map(from: entity))
	}

	public func getExpenses() throws -> [EstalviaExpense] {
		let entities: [EstalviaExpenseRemote] = try localDataSourceProvider.getAll()

		return entities.map { ExpenseMapper.map(from: $0) }
	}
}

struct ExpenseMapper {
	static func map(
		from domainEntity: EstalviaExpense
	) -> EstalviaExpenseRemote {
		EstalviaExpenseRemote(
			id: domainEntity.id,
			name: domainEntity.name,
			amount: domainEntity.amount,
			date: domainEntity.date
		)
	}

	static func map(
		from domainEntity: EstalviaExpenseRemote
	) -> EstalviaExpense {
		EstalviaExpense(
			id: domainEntity.id,
			name: domainEntity.name,
			amount: domainEntity.amount,
			date: domainEntity.date
		)
	}
}
