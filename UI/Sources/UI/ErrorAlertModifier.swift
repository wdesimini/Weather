//
//  SwiftUIView.swift
//  UI
//
//  Created by Wilson Desimini on 12/12/24.
//

import SwiftUI

struct ErrorAlertModifier: ViewModifier {
    let title: String
    @Binding var error: Error?

    var message: String {
        error?.localizedDescription ?? ""
    }

    func body(content: Content) -> some View {
        content.alert(isPresented: .init(get: { error != nil }, set: { _ in error = nil })) {
            Alert(title: Text(title), message: Text(message), dismissButton: .default(Text("OK")))
        }
    }
}

extension View {
    public func errorAlert(title: String = "Error", error: Binding<Error?>) -> some View {
        modifier(ErrorAlertModifier(title: title, error: error))
    }
}

private enum MockError: LocalizedError {
    case test

    var errorDescription: String? {
        "This is a test error"
    }
}

#Preview {
    Text("Hello, World!")
        .errorAlert(title: "Error", error: .constant(MockError.test))
}
