//
//  HomeSaveExpanseUseCase.swift
//  Estalvia
//
//  Created by Alex.personal on 15/11/25.
//

import Foundation

public protocol HomeSaveExpanseUseCaseProtocol {
	func saveExpense(amount: String, description: String) throws
	func saveExpense(expense: EstalviaExpense) throws
}

public struct HomeSaveExpanseUseCase: HomeSaveExpanseUseCaseProtocol {
	private let repository: HomeRepositoryProtocol

	init(repository: HomeRepositoryProtocol) {
		self.repository = repository
	}

	public func saveExpense(amount: String, description: String) throws {
		do {
            let amount = try parseAmount(amount)
			let entity = EstalviaExpense(id: UUID().uuidString, name: description, amount: amount, date: Date.now)
			try repository.save(entity: entity)
		} catch {
			throw error
		}
	}

	public func saveExpense(expense: EstalviaExpense) throws {
		do {
			try repository.save(entity: expense)
		} catch {
			throw error
		}
	}

	private func parseAmount(_ amount: String) throws -> Double {
		guard let parsedAmount = Double(amount) else {
			throw HomeSaveExpanseUseCaseError.cannotParseAmount(amount: amount)
		}
		return parsedAmount
	}
}

enum HomeSaveExpanseUseCaseError: Error {
	case cannotParseAmount(amount: String)
}
