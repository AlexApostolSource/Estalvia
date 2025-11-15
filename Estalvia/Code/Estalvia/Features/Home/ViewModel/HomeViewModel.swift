//
//  HomeViewModel.swift
//  Estalvia
//
//  Created by Alex.personal on 9/11/25.
//

import SwiftUI

final class HomeViewModel: Observable {
	private let useCase: HomeSaveExpanseUseCaseProtocol

	init(useCase: HomeSaveExpanseUseCaseProtocol) {
		self.useCase = useCase
	}
}
