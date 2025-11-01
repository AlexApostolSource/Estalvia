//
//  Test.swift
//  SwiftPersistance
//
//  Created by Alex.personal on 1/11/25.
//

import Foundation
import Testing
import SwiftData
@testable import SwiftPersistance

@Model
class User {
	var id: UUID = UUID()
	var name: String = ""

	init(id: UUID, name: String) {
		self.id = id
		self.name = name
	}
}

struct Test {

	@Test("test empty fetch")
	func testEmptyFetch() throws {
		// Given
		let context = MockContext()
		let sut = makeSut(context: context)

		// When
		let result: [User] = try sut.getAll()

		// Then
		#expect(result.isEmpty)
		#expect(context.fetchCallCount == 1)
	}

	@Test("test insert and fetch returns value")
	func testFetchReturnsValue() throws {
		// Given
		let context = MockContext()
		let id = UUID()
		let name = "Test"
		let user = User(id: id, name: name)
		context.insert(user)
		let sut = makeSut(context: context)

		// When
		let descriptor = FetchDescriptor<User>()
		let result: User? = try sut.fetch(descriptor)

		// Then
		#expect(context.fetchCallCount == 1)
		#expect(result?.id == id)
		#expect(result?.name == name)
	}

	@Test("Test get all")
	func testGetAll() throws {
		// Given
		let context = MockContext()
		let id1 = UUID()
		let name1 = "Test1"
		let user1 = User(id: id1, name: name1)
		context.insert(user1)
		let id2 = UUID()
		let name2 = "Test2"
		let user2 = User(id: id2, name: name2)
		context.insert(user2)
		let sut = makeSut(context: context)

		// When
		let users: [User] = try sut.getAll()

		// Then
		#expect(users.count == 2)
		#expect(users.contains(where: { $0.id == id1 && $0.name == name1 }))
		#expect(users.contains(where: { $0.id == id2 && $0.name == name2 }))
	}

	@Test("Test delete")
	func testDelete() throws {
		// Given
		let context = MockContext()
		let id = UUID()
		let name = "Test"
		let user = User(id: id, name: name)
		context.insert(user)
		let sut = makeSut(context: context)

		// When
		try sut.delete(user)

		// Then
		#expect(context.models.isEmpty)
		#expect(context.deleteCallCount == 1)
	}

	private func makeSut(context: MockContext = MockContext()) -> SwiftPersistanceSwiftData {
		SwiftPersistSwiftDataProvider(context: context)
	}
}

private class MockContext: SwiftPersistSwiftDataProviderContext, @unchecked Sendable {
	var models: [UUID: any PersistentModel] = [:]
	var deleteCallCount: Int = 0
	var insertCallCount: Int = 0
	var saveCallCount: Int = 0
	var fetchCallCount: Int = 0

	/*
	 predicate: which rows you want (equivalent to WHERE).

	 sortBy: ordering (equivalent to ORDER BY).

	 fetchOffset / fetchLimit: pagination.
	 */
	func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> [T] where T: PersistentModel {
		fetchCallCount += 1

		// 1) Narrow to requested type `T`
		var items = models.values.compactMap { $0 as? T }

		// 2) Apply predicate if present
		if let predicate = descriptor.predicate {
			items = try items.filter(predicate)
		}

		// 3) Apply sorting if provided
		if !descriptor.sortBy.isEmpty {
			items = items.sorted(using: descriptor.sortBy)
		}

		// 4) Apply offset then limit
		if let offset = descriptor.fetchOffset, offset > 0 {
			items = Array(items.dropFirst(offset))
		}
		if let limit = descriptor.fetchLimit, limit > 0 {
			items = Array(items.prefix(limit))
		}

		return items
	}

	func insert<T>(_ model: T) where T : PersistentModel {
		insertCallCount += 1
		models[UUID()] = model
	}

	func delete<T>(_ model: T) where T : PersistentModel {
		deleteCallCount += 1
		let modelToDelete = models.first(where: {$1 as? T == model})
		models.removeValue(forKey: modelToDelete?.key ?? UUID())
	}

	func save() throws {
		saveCallCount += 1
	}
}
