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
	func save<T: Sendable>(entity: T) async throws where T: EstalviaSwiftDataSourceEntity

		/// Returns the **first** element for the requested type or throws if no entities exist.
		///
		/// - Returns: The first stored instance of `T`.
		/// - Throws: `SwiftPersistSwiftDataProviderError.noEntityFound(model:)`
		///           if the store has no entities of type `T`, or fetch errors from SwiftData.
	func getFirst<T>() async throws -> T where T: EstalviaSwiftDataSourceEntity

		/// Returns **all** elements for the requested type.
		///
		/// - Returns: An array of all stored instances of `T`.
		/// - Throws: Any error thrown by `ModelContext.fetch(_:)`.
	func getAll<T>() async throws -> [T] where T: EstalviaSwiftDataSourceEntity

		/// Deletes a specific element and **persists** the context.
		///
		/// - Parameters:
		///   - entity: The concrete `@Model` instance to delete.
		/// - Effects:
		///   - Calls `context.delete(entity)` followed by `context.save()`.
		/// - Throws: Any error thrown by `ModelContext.save()`.
	func delete<T: Sendable>(_ entity: T) async throws where T: EstalviaSwiftDataSourceEntity

		/// Optional hook for bootstrapping (e.g., migrations, seeding, integrity checks).
		/// Default implementations may no-op.
	func setup() async throws
}


public actor SwiftPersistSwiftDataProvider: SwiftPersistanceSwiftData {

	private let modelContainer: ModelContainer
	private let context: ModelContext

	public init(modelContainer: ModelContainer) {
		self.modelContainer = modelContainer
		self.context = ModelContext(modelContainer)
	}

	public func setup() async throws {

	}

	public func getAll<T: Sendable>() async throws -> [T] where T: EstalviaSwiftDataSourceEntity {
		try context.fetch(FetchDescriptor<T>())
	}

	public func save<T>(entity: T) async throws where T: EstalviaSwiftDataSourceEntity {
		context.insert(entity)
	}

	public func getFirst<T: Sendable>() async throws -> T where T: EstalviaSwiftDataSourceEntity {
		var description = FetchDescriptor<T>()
		description.fetchLimit = 1
		guard let first = try context.fetch(description).first else {
			throw SwiftPersistSwiftDataProviderError.noEntityFound(model: "\(T.self)")
		}
		return first
	}
	public func delete<T: Sendable>(_ entity: T) async throws where T: EstalviaSwiftDataSourceEntity {
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
