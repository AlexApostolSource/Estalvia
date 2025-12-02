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
	public var id: String
	public var name: String
	public var amount: Double
	public var date: Date
	public var childs: [EstalviaExpenseRemote]?

	public init(id: String, name: String, amount: Double, date: Date, childs: [EstalviaExpenseRemote]? = nil) {
		self.id = id
		self.name = name
		self.amount = amount
		self.date = date
		self.childs = childs
	}
}
