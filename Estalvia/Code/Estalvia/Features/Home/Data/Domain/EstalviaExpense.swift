//
//  EstalviaExpense.swift
//  Estalvia
//
//  Created by Alex.personal on 9/11/25.
//
import EstalviaDesignSystem
import Foundation

public struct EstalviaExpense: Identifiable {
	public let id: String
	public let name: String
	public let amount: Double
	public let date: Date
	public var parentId: String?   // nil = raíz
	public var transactions: [EstalviaTransaction] = []

	public init(
		id: String,
		name: String,
		amount: Double,
		date: Date,
		parentId: String? = nil,
		transactions: [EstalviaTransaction] = []
	) {
		self.id = id
		self.name = name
		self.amount = amount
		self.date = date
		self.parentId = parentId
		self.transactions = transactions
	}
}

public struct EstalviaTransaction: Identifiable {
	public let id: String
	public let name: String
	public let date: Date
	public let image: String?
	public let amount: EstalviaExpenseTransactionTypeData
	public let initialAmount: EstalviaExpenseTransactionTypeData
	public let remainingAmount: EstalviaExpenseTransactionTypeData
	public let parentId: String?

	public init(
		id: String,
		name: String,
		date: Date,
		image: String?,
		amount: EstalviaExpenseTransactionTypeData,
		initialAmount: EstalviaExpenseTransactionTypeData,
		remainingAmount: EstalviaExpenseTransactionTypeData,
		parentId: String?
	) {
		self.id = id
		self.name = name
		self.date = date
		self.image = image
		self.amount = amount
		self.initialAmount = initialAmount
		self.remainingAmount = remainingAmount
		self.parentId = parentId
	}
}
