//
//  EstalviaButtonTheme.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 14/9/25.
//

import SwiftUI

public enum EstalviaButtonTheme: Sendable {
    case small, medium, large, circle
    var padding: EdgeInsets {
		switch self {
		case .small:  return .init(top: 10, leading: 12, bottom: 10, trailing: 12)
		case .medium: return .init(top: 15, leading: 16, bottom: 15, trailing: 16)
		case .large:  return .init(top: 18, leading: 20, bottom: 18, trailing: 20)
		case .circle: return .init(top: 0, leading: 0, bottom: 0, trailing: 0)
		}
    }

	var font: Font {
		switch self {
		case .small:
			return .system(size: 12).bold()
		case .medium:
			return .system(size: 14, weight: .bold)
		case .large:
			return .system(size: 16, weight: .bold)
		case .circle:
			return .system(size: 14, weight: .bold)
		}
	}

	var cornerRadius: CGFloat {
		switch self {
		case .small:  return 12
		case .medium: return 14
		case .large:  return 16
		case .circle: return 2151
		}
	}

    var primaryColor: Color {
        return .estalviaPrimaryBlue
    }

    init() {
        self = .large
    }
}
