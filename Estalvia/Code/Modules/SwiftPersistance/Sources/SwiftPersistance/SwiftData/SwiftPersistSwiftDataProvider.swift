//
//  EstalviaSwiftDataProvider.swift
//  EstalviaLocalDataSource
//
//  Created by Alex.personal on 25/10/25.
//
import Foundation
import SwiftData

// Typealias that constrains repository operations to SwiftData models.
/// All persisted models must be annotated with `@Model`, which conform to `PersistentModel`.
public typealias EstalviaSwiftDataSourceEntity = PersistentModel

	/// A lightweight, actor-isolated persistence interface over SwiftData.
	/// - Concurrency: All operations are executed inside an `actor` that owns its `ModelContext`,
	///   ensuring thread-safety without blocking the main thread.
	/// - Generics: Each method is generic over a concrete `@Model` `T` to keep type safety.
public protocol SwiftPersistanceSwiftData {
		/// Inserts a concrete SwiftData model and **persists** the context.
		///
		/// - Parameters:
		///   - entity: The concrete `@Model` instance to insert.
		/// - Effects:
		///   - Calls `context.insert(entity)` followed by `context.save()`.
		/// - Throws: Any error thrown by `ModelContext.save()`.
	func save<T>(entity: T) throws where T: EstalviaSwiftDataSourceEntity

		/// Returns the **first** element for the requested type or throws if no entities exist.
		///
		/// - Returns: The first stored instance of `T`.
		/// - Throws: `SwiftPersistSwiftDataProviderError.noEntityFound(model:)`
		///           if the store has no entities of type `T`, or fetch errors from SwiftData.
	func getFirst<T>(sortBy: [SortDescriptor<T>]) throws -> T where T: EstalviaSwiftDataSourceEntity

		/// Returns **all** elements for the requested type.
		///
		/// - Returns: An array of all stored instances of `T`.
		/// - Throws: Any error thrown by `ModelContext.fetch(_:)`.
	func getAll<T>() throws -> [T] where T: EstalviaSwiftDataSourceEntity

		/// Deletes a specific element and **persists** the context.
		///
		/// - Parameters:
		///   - entity: The concrete `@Model` instance to delete.
		/// - Effects:
		///   - Calls `context.delete(entity)` followed by `context.save()`.
		/// - Throws: Any error thrown by `ModelContext.save()`.
	func delete<T>(_ entity: T) throws where T: EstalviaSwiftDataSourceEntity

	/// Returns the **first** record of type `T` matching the given `FetchDescriptor`.
	///
	/// This method performs a fetch on the underlying `ModelContext` and returns only
	/// the **first** matching element (or `nil` if there are no results). Use it when
	/// you expect zero or one element. For collections, prefer `getAll()`.
	///
	/// - Parameter descriptor: A `FetchDescriptor<T>` defining `predicate`, `sortBy`,
	///   `fetchOffset`, and/or `fetchLimit`. For best performance, set `fetchLimit = 1`
	///   when you only need existence or the first result.
	/// - Returns: The first entity of type `T`, or `nil` if no match is found.
	/// - Throws: Any error thrown by `ModelContext.fetch(_:)`.
	/// - Effects: Read-only; does not mutate the context.
	/// - Concurrency: Call from the persistence actor that owns the context. Does not
	///   block the main thread.
	/// - Complexity: Approximately `O(k log k)` with sorting (where *k* is the number
	///   of items passing the predicate) or `O(k)` without sorting. Use a selective
	///   predicate and `fetchLimit = 1` to minimize *k*.
	/// - Important: On large stores, **always** cap with `fetchLimit = 1` to avoid
	///   materializing unnecessary rows when only one element is needed.
	/// - SeeAlso: `getAll()`
	///
	/// ### Example
	/// ```swift
	/// var d = FetchDescriptor<User>()
	/// d.predicate = #Predicate { $0.name == "Alex" }
	/// d.fetchLimit = 1
	/// let user: User? = try provider.fetch(d)
	/// ```
	func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> T where T: EstalviaSwiftDataSourceEntity

	/// Saves Contest
	func saveContext() throws
}

public struct SwiftPersistSwiftDataProvider: SwiftPersistanceSwiftData {
	private let context: SwiftPersistSwiftDataProviderContext

	public init(context: SwiftPersistSwiftDataProviderContext) {
		self.context = context
	}

	public func getAll<T>() throws -> [T] where T: EstalviaSwiftDataSourceEntity {
		try context.fetch(FetchDescriptor<T>())
	}

	public func save<T>(entity: T) throws where T: EstalviaSwiftDataSourceEntity {
		context.insert(entity)
		try context.save()
	}

	public func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> T where T: EstalviaSwiftDataSourceEntity {
		var descriptor = descriptor
		descriptor.fetchLimit = 1
		guard let entity = try? context.fetch(descriptor).first else {
			throw SwiftPersistSwiftDataProviderError.noEntityFound(model: "\(T.self)")
		}
		return entity
	}

	public func getFirst<T>(
		sortBy: [SortDescriptor<T>] = []
	) throws -> T where T: EstalviaSwiftDataSourceEntity {
		var descriptor = FetchDescriptor<T>(sortBy: sortBy)
		descriptor.fetchLimit = 1
		let result = try context.fetch(descriptor)
		guard let first = result.first else { throw SwiftPersistSwiftDataProviderError.noEntityFound(model: "\(T.self)") }
		return first
	}
	public func delete<T>(_ entity: T) throws where T: EstalviaSwiftDataSourceEntity {
		context.delete(entity)
		try context.save()
	}

	public func saveContext() throws {
		try context.save()
	}
}

public enum SwiftPersistSwiftDataProviderError: Error {
	case incompatibleType
	case decodingFailed(underlyingError: Error)
	case setupFailed(underlyingError: Error)
	case noEntityFound(model: String)
}

public protocol SwiftPersistSwiftDataProviderContext {
	func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> [T] where T: PersistentModel
	func insert<T>(_ model: T) where T: PersistentModel
	func delete<T>(_ model: T) where T: PersistentModel
	func save() throws
}

extension ModelContext: SwiftPersistSwiftDataProviderContext {}
