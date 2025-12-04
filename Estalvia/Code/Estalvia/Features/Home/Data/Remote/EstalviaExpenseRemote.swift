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

	public init(
		id: String,
		name: String,
		amount: Double,
		date: Date,
		parentId: String? = nil
	) {
		self.id = id
		self.name = name
		self.amount = amount
		self.date = date
		self.parentId = parentId
	}
}
