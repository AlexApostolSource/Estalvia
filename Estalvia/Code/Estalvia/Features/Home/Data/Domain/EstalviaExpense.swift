//
//  EstalviaExpense.swift
//  Estalvia
//
//  Created by Alex.personal on 9/11/25.
//

import Foundation

public struct EstalviaExpense: Identifiable {
	public let id: String
	public let name: String
	public let amount: Double
	public let date: Date
	public let child: [EstalviaExpense]?

	public init(id: String, name: String, amount: Double, date: Date, child: [EstalviaExpense]? = nil) {
		self.id = id
		self.name = name
		self.amount = amount
		self.date = date
		self.child = child
	}
}
