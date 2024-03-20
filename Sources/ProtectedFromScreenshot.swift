//
//  ProtectedFromScreenshot.swift
//
//
//  Created by Денис Колеснёв on 19.03.2024.
//

import SwiftUI

public struct ProtectedFromScreenshot<Content: View>: UIViewControllerRepresentable {

    private let isProtected: Bool
    private let content: () -> Content

    public init(isProtected: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.isProtected = isProtected
        self.content = content
    }

    public func makeUIViewController(context: Context) -> ProtectedFromScreenshotViewController<Content> {
        ProtectedFromScreenshotViewController(isProtect: isProtected, content: content)
    }

    public func updateUIViewController(_ uiViewController: ProtectedFromScreenshotViewController<Content>, context: Context) {
        uiViewController.isProtect = isProtected
    }
}

public extension View {
    
    func protectedFromScreenshot(_ isProtected: Bool) -> some View {
        modifier(ProtectedFromScreenshotModifier(isProtected: isProtected))
    }
}

private struct ProtectedFromScreenshotModifier: ViewModifier {
    
    let isProtected: Bool
    
    func body(content: Content) -> some View {
        ProtectedFromScreenshot(isProtected: isProtected) {
            content
        }
    }
}
