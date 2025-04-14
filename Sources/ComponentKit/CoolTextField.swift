//
//  CoolTextField.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 27/3/25.
//

import SwiftUI

public struct CoolTextField: View {
    let label: String
    let placeholder: String
    @Binding var value: String
    let validation: ValidationFunctions
    let isFocused: Bool
    
    @State private var errorMessage: String?
    
    public init(label: String, placeholder: String, value: Binding<String>, validation: ValidationFunctions, isFocused: Bool = false) {
        self.label = label
        self.placeholder = placeholder
        self._value = value
        self.validation = validation
        self.isFocused = isFocused
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.headline)
                .padding(.leading)
                .accessibilityHidden(true)
            HStack(alignment: .top) {
                TextField(placeholder,
                          text: $value,
                          axis: .vertical)
                //                        .lineLimit(2, reservesSpace: true)
                .accessibilityLabel("\(label). \(placeholder)")
                .accessibilityHint(Text("Text Field. \(errorMessage != nil ? "Error: \(errorMessage!)" : "Enter a value")"))
                .accessibilityValue(value)
                
                if !value.isEmpty && isFocused {
                    Button {
                        value = ""
                    } label: {
                        Image(systemName: "xmark")
                            .symbolVariant(.circle.fill)
                    }
                    .buttonStyle(.plain)
                    .opacity(0.2)
                    .accessibilityLabel("Erase text")
                    .accessibilityHint("Erase the text in the text field")
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background {
                Color.secondary.opacity(0.1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 3)
                    .fill(.linearGradient(colors: [.red.opacity(0.9), .red.opacity(0.5)], startPoint: .leading, endPoint: .trailing))
                    .opacity(errorMessage != nil ? 1.0 : 0.0)
            }
            
            Text("\(label)\(errorMessage ?? "")")
                .font(.caption)
                .foregroundStyle(.red)
                .padding(.leading)
                .opacity(errorMessage != nil ? 1.0 : 0.0)
        }
        .onChange(of: value) {
            errorMessage = validation.validate(value)
        }
        .animation(.default, value: errorMessage)
    }
}

#Preview {
    @Previewable @State var value = ""
    @Previewable @State var isFocused = false
    CoolTextField(label: "Title",
                  placeholder: "Title of the Score",
                  value: $value,
                  validation: .isNotEmpty,
                  isFocused: isFocused)
}
