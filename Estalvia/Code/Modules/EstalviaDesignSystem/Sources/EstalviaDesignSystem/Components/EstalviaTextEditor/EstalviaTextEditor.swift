//
//  EstalviaTextEditor.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 9/12/25.
//

import SwiftUI

public struct EstalviaTextEditor: View {
	private var text: Binding<String>
	private let description: String
	var tokens = TextFieldTokens()

	public var body: some View {
		VStack {
			HStack {
				Text(description).estalviaTextView(.subtitle)
				Spacer()
			}

			TextEditor(text: text).overlay(
				RoundedRectangle(cornerRadius: tokens.cornerRadius)
		   .stroke(tokens.border))
		}
	}

	public init(text: Binding<String>, description: String) {
		self.text = text
		self.description = description
	}
}

public struct EstalviaTextEditorPreview: View {
	@State var text = ""
	public var body: some View {
		EstalviaTextEditor(text: $text, description: "test").padding(16)
	}

	public init() {}
}

#Preview {
	EstalviaTextEditorPreview()
}
