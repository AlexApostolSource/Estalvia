//
//  HomeRepository.swift
//  Estalvia
//
//  Created by Alex.personal on 9/11/25.
//

import SwiftPersistance

public protocol HomeRepositoryProtocol {
	func save(entity: EstalviaExpense) throws
}

public struct HomeRepository: HomeRepositoryProtocol {
	private let localDataSourceProvider: SwiftPersistanceSwiftData

	init(localDataSourceProvider: SwiftPersistanceSwiftData) {
		self.localDataSourceProvider = localDataSourceProvider
	}

	public func save(entity: EstalviaExpense) throws {
		try localDataSourceProvider.save(entity: ExpenseMapper.map(from: entity))
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
}
