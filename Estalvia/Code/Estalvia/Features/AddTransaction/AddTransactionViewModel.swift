//
//  AddTransactionViewModel.swift
//  Estalvia
//
//  Created by Alex.personal on 9/12/25.
//

import SwiftUI

@Observable
final class AddTransactionViewModel {
	var amount: String = ""
	var category: String = ""
	var description: String = ""
	var notes: String = ""
}
