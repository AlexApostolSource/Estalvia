//
//  EstalviaTextField.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 20/9/25.
//

import SwiftUI

public struct EstalviaTextFieldPreview: View {
    @State private var email = ""
    @State private var email1 = ""
    @State private var email2 = ""
    @State private var email3 = ""
    @State private var email4 = ""
    public var body: some View {
        VStack {
            EstalviaTextField(
                title: "Email",
                text: $email1,
                placeholder: "tucorreo@dominio.com",
                keyboard: .emailAddress,
                textContentType: .emailAddress
            )
            EstalviaTextField(
                title: "Email",
                text: $email2,
                placeholder: "tucorreo@dominio.com",
                error: "MyError",
                keyboard: .emailAddress,
                textContentType: .emailAddress
            )

            EstalviaTextField(
                title: "Number",
                text: $email3,
                placeholder: "Numbers",
                helper: "Helper",
                keyboard: .numberPad,
                textContentType: .telephoneNumber
            )

            EstalviaTextField(
                title: "Password",
                text: $email4,
                placeholder: "Password",
                helper: "Password",
                keyboard: .default,
                textContentType: .password,
                isSecure: true
            )
        }
        .padding(.all)

    }

    public init () {}
}

#Preview {
    EstalviaTextFieldPreview()
}


// 1) Tokens de estilo para todo el DS
public struct TextFieldTokens {
    var cornerRadius: CGFloat = 12
    var fill = Color(.systemGray6)
    var border = Color(.separator)
    var borderFocused = Color.accentColor
    var borderError = Color.red
    var labelFont: Font = .subheadline
    var helperFont: Font = .footnote

    public init(
        cornerRadius: CGFloat = 12,
        fill: Color = Color(.systemGray6),
        border: Color = Color(.separator),
        borderFocused: Color = Color.accentColor,
        borderError: Color = Color.red,
        labelFont: Font = .subheadline,
        helperFont: Font = .footnote
    ) {
        self.cornerRadius = cornerRadius
        self.fill = fill
        self.border = border
        self.borderFocused = borderFocused
        self.borderError = borderError
        self.labelFont = labelFont
        self.helperFont = helperFont
    }
}

public struct EstalviaTextField<Leading: View, Trailing: View>: View {
    let title: String
    @Binding var text: String
    var placeholder: String = ""
    var helper: String? = nil
    var error: String? = nil
    var keyboard: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    var isSecure: Bool = false
    var autocapitalization: TextInputAutocapitalization = .sentences
    var autocorrectionDisabled: Bool = false
    @State var isPasswordVisible: Bool = false
    var leading: () -> Leading
    var trailing: () -> Trailing

    @FocusState private var focused: Bool
    var tokens = TextFieldTokens()

   public init(
        title: String,
        text: Binding<String>,
        placeholder: String = "",
        helper: String? = nil,
        error: String? = nil,
        keyboard: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil,
        isSecure: Bool = false,
        autocapitalization: TextInputAutocapitalization = .sentences,
        autocorrectionDisabled: Bool = false,
        tokens: TextFieldTokens = TextFieldTokens(),
        @ViewBuilder leading: @escaping () -> Leading = { EmptyView() },
        @ViewBuilder trailing: @escaping () -> Trailing = { EmptyView() }
    ) {
        self.title = title
        self._text = text
        self.placeholder = placeholder
        self.helper = helper
        self.error = error
        self.keyboard = keyboard
        self.textContentType = textContentType
        self.isSecure = isSecure
        self.tokens = tokens
        self.autocapitalization = autocapitalization
        self.autocorrectionDisabled = autocorrectionDisabled
        self.leading = leading
        self.trailing = trailing
    }

   public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .estalviaTextView(.subtitle)

            HStack(spacing: 8) {
                leading()
                Group {
                    if isSecure && !isPasswordVisible {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .textInputAutocapitalization(autocapitalization)
                .disableAutocorrection(autocorrectionDisabled)
                .keyboardType(keyboard)
                .textContentType(textContentType)
                .focused($focused)
                .submitLabel(.done)

                if isSecure {
                    Button {
                        isPasswordVisible.toggle()
                    } label: {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .imageScale(.medium)
                            .accessibilityLabel(isPasswordVisible ? "Mostrar contraseña" : "Ocultar contraseña")
                    }.buttonStyle(.plain)
                        .contentShape(Rectangle())
                        .padding(.trailing, 2)
                }

                trailing()
            }
            .padding(.horizontal, 12).padding(.vertical, 10)
            .background(RoundedRectangle(cornerRadius: tokens.cornerRadius).fill(tokens.fill))
            .overlay(
                RoundedRectangle(cornerRadius: tokens.cornerRadius)
                    .stroke(error != nil ? tokens.borderError : (focused ? tokens.borderFocused : tokens.border), lineWidth: 1)
            )

            if let msg = error {
                Text(msg).font(tokens.helperFont).foregroundStyle(tokens.borderError)
                    .accessibilityHint(msg)
            } else if let tip = helper {
                Text(tip).font(tokens.helperFont).foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
    }
}
