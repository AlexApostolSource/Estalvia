//
//  AnyShape.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 9/11/25.
//

import SwiftUI

public struct AnyShape: Shape {
	private let _path: @Sendable (CGRect) -> Path

	public func path(in rect: CGRect) -> Path {
		_path(rect)
	}

	public init<S: Shape & Sendable>(_ shape: S) {
		_path = { rect in
			shape.path(in: rect)
		}
	}
}
