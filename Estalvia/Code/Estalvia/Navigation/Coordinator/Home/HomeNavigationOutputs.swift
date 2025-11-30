//
//  HomeNavigationOutputs.swift
//  Estalvia
//
//  Created by Alex.personal on 30/11/25.
//

@MainActor
protocol HomeNavigationOutputs: AnyObject {
	func showAddExpense(onSaved: (() -> Void)?)
}
