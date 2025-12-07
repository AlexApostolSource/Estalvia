//
//  AddExpenseChildValidationUseCaseTests.swift
//  Estalvia
//
//  Created by Alex.personal on 7/12/25.
//

@testable import Estalvia
import Foundation
import Testing

struct AddExpenseChildValidationUseCaseTests {

	@Test func test_onAddingChild_totalAmount_surpasses_parentAmount_throws() async throws {
		let parentId = "1"
		let parent = EstalviaExpense.makeStub(id: parentId, amount: 100)
		let children = [
			EstalviaExpense.makeStub(
				id: "3",
				amount: 20,
				parentId: parentId
			),
			EstalviaExpense.makeStub(
				id: "2",
				amount: 20,
				parentId: parentId
			)
		]

		let child = EstalviaExpense.makeStub(id: "3", amount: 1000, parentId: parentId)

		let sut = makeSUT()

		do {
			try await sut.canAddChildExpense(parent: parent, children: children, child: child)
			#expect(Bool(false), "should not be able to add the child expense")
		} catch {
			#expect(Bool(true), "error thrown child total amount cannot surpass parent amount")
		}
	}

	@Test func test_onAddingChild_totalAmount_doesNotSurpass_parentAmount_doesNotThrow() async throws {
		let parentId = "1"
		let parent = EstalviaExpense.makeStub(id: parentId, amount: 100)
		let children = [
			EstalviaExpense.makeStub(
				id: "3",
				amount: 20,
				parentId: parentId
			),
			EstalviaExpense.makeStub(
				id: "2",
				amount: 20,
				parentId: parentId
			)
		]

		let child = EstalviaExpense.makeStub(id: "3", amount: 1, parentId: parentId)

		let sut = makeSUT()

		do {
			try await sut.canAddChildExpense(parent: parent, children: children, child: child)
			#expect(Bool(true), "should be able to add child amount does NOT surpass parent amount")
		} catch {
			#expect(Bool(false), "should not throw an error")
		}
	}

	private func makeSUT() -> AddExpenseChildValidationUseCase {
		AddExpenseChildValidationUseCase()
	}
}
