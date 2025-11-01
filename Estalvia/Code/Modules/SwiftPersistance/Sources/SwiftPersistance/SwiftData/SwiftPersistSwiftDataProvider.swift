//
//  EstalviaSwiftDataProvider.swift
//  EstalviaLocalDataSource
//
//  Created by Alex.personal on 25/10/25.
//
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
	func getFirst<T>() throws -> T where T: EstalviaSwiftDataSourceEntity

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

	func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> T? where T: EstalviaSwiftDataSourceEntity
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

	public func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> T? where T: EstalviaSwiftDataSourceEntity {
		try context.fetch(descriptor).first
	}

	public func getFirst<T>() throws -> T where T: EstalviaSwiftDataSourceEntity {
		var description = FetchDescriptor<T>()
		description.fetchLimit = 1
		guard let first = try context.fetch(description).first else {
			throw SwiftPersistSwiftDataProviderError.noEntityFound(model: "\(T.self)")
		}
		return first
	}

	public func delete<T>(_ entity: T) throws where T: EstalviaSwiftDataSourceEntity {
		context.delete(entity)
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
	func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> [T] where T : PersistentModel
	func insert<T>(_ model: T) where T : PersistentModel
	func delete<T>(_ model: T) where T : PersistentModel
	func save() throws
}

extension ModelContext: SwiftPersistSwiftDataProviderContext {}
