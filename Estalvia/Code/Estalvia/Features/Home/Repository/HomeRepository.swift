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
	func update(expense: EstalviaExpense) throws
}

public struct HomeRepository: HomeRepositoryProtocol {
	private let localDataSourceProvider: SwiftPersistanceSwiftData

	init(localDataSourceProvider: SwiftPersistanceSwiftData) {
		self.localDataSourceProvider = localDataSourceProvider
	}

	public func save(entity: EstalviaExpense) throws {
		try localDataSourceProvider.save(entity: ExpenseMapper.toRemote(entity))
	}

	public func getExpenses() throws -> [EstalviaExpense] {
		let entities: [EstalviaExpenseRemote] = try localDataSourceProvider.getAll()

		return entities.map { ExpenseMapper.toDomain($0) }
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

	public func update(expense: EstalviaExpense) throws {
		// 1. Buscar el modelo de persistencia en SwiftData usando su id de dominio
		let expenseId = expense.id

		var descriptor = FetchDescriptor<EstalviaExpenseRemote>()
			descriptor.predicate = #Predicate<EstalviaExpenseRemote> { remote in
				remote.id == expenseId
			}
		descriptor.fetchLimit = 1

		let persisted: EstalviaExpenseRemote = try localDataSourceProvider.fetch(descriptor)

		// 2. Mapear campos de dominio → persistencia
		persisted.amount = expense.amount
		persisted.date = expense.date
		persisted.childs = expense.child.map { children in
			children.map { ExpenseMapper.toRemote($0) }
		}
		persisted.name = expense.name

		try localDataSourceProvider.saveContext()
	}
}

struct ExpenseMapper {

	// Dominio -> Persistencia
	static func toRemote(_ domain: EstalviaExpense) -> EstalviaExpenseRemote {
		EstalviaExpenseRemote(
			id: domain.id,
			name: domain.name,
			amount: domain.amount,
			date: domain.date,
			childs: domain.child?.map { toRemote($0) }    // hijos recursivos
		)
	}

	// Persistencia -> Dominio
	static func toDomain(_ remote: EstalviaExpenseRemote) -> EstalviaExpense {
		EstalviaExpense(
			id: remote.id,
			name: remote.name,
			amount: remote.amount,
			date: remote.date,
			child: remote.childs?.map { toDomain($0) }
		)
	}
}
