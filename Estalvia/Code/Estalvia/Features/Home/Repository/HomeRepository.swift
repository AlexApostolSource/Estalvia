//
//  HomeRepository.swift
//  Estalvia
//
//  Created by Alex.personal on 9/11/25.
//

import Foundation
import SwiftData
import SwiftPersistance

public protocol HomeRepositoryProtocol {
	func save(entity: EstalviaExpense) throws
	func getExpenses() throws -> [EstalviaExpense]
	func deleteExpense(expense: EstalviaExpense) throws
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

	public func deleteExpense(expense: EstalviaExpense) throws {
		// 1. Capturamos el id como valor "simple"
		let id = expense.id   // String / UUID / lo que sea tu id

		// 2. Creamos el descriptor tipado
		var descriptor = FetchDescriptor<EstalviaExpenseRemote>()

		// 3. Usamos el id capturado en el #Predicate
		descriptor.predicate = #Predicate<EstalviaExpenseRemote> { remote in
			remote.id == id
		}

		// 4. Obtenemos la entidad real en el contexto
		let remote: EstalviaExpenseRemote = try localDataSourceProvider.fetch(descriptor)

		// 5. Borramos esa instancia concreta
		try localDataSourceProvider.delete(remote)
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
