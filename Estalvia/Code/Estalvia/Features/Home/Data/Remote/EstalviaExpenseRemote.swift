//
//  EstalviaExpenseRemote.swift
//  Estalvia
//
//  Created by Alex.personal on 9/11/25.
//

import Foundation
import SwiftData

@Model
public final class EstalviaExpenseRemote {
	@Attribute(.unique)
	public var id: String
	public var name: String
	public var amount: Double
	public var date: Date

	/// id del padre. `nil` = gasto raíz (sin padre)
	public var parentId: String?
	public var transactions: [EstalviaTransactionRemote]?

	public init(
		id: String,
		name: String,
		amount: Double,
		date: Date,
		parentId: String? = nil,
		transactions: [EstalviaTransactionRemote]?
	) {
		self.id = id
		self.name = name
		self.amount = amount
		self.date = date
		self.parentId = parentId
		self.transactions = transactions
	}
}

public enum EstalviaExpenseRemoteTransactionType: Codable {
	case positive
	case negative
	case idle
}

public struct EstalviaExpenseProtocolRemote: Codable {
	var type: EstalviaExpenseRemoteTransactionType
	var title: String
	var amount: String

	public init(type: EstalviaExpenseRemoteTransactionType, title: String, amount: String) {
		self.type = type
		self.title = title
		self.amount = amount
	}
}

@Model public final class EstalviaTransactionRemote {
	@Attribute(.unique)
	public var id: String
	public var name: String
	public var date: Date
	public var image: String?
	public var amount: EstalviaExpenseProtocolRemote
	public var initialAmount: EstalviaExpenseProtocolRemote
	public var remainingAmount: EstalviaExpenseProtocolRemote
	public var parentId: String?

	public init(
		id: String,
		name: String,
		date: Date,
		image: String?,
		amount: EstalviaExpenseProtocolRemote,
		initialAmount: EstalviaExpenseProtocolRemote,
		remainingAmount: EstalviaExpenseProtocolRemote,
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
