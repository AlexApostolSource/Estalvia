//
//  HomeSaveExpanseUseCase.swift
//  Estalvia
//
//  Created by Alex.personal on 15/11/25.
//

import Foundation

public protocol HomeSaveExpanseUseCaseProtocol {
	func saveExpense(amount: String, description: String)
}

public struct HomeSaveExpanseUseCase: HomeSaveExpanseUseCaseProtocol {
	private let repository: HomeRepositoryProtocol

	init(repository: HomeRepositoryProtocol) {
		self.repository = repository
	}

	public func saveExpense(amount: String, description: String) {
		do {
            let amount = try parseAmount(amount)
			let entity = EstalviaExpense(id: UUID().uuidString, name: description, amount: amount, date: Date.now)
			try repository.save(entity: entity)
		} catch {
			print(error)
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
