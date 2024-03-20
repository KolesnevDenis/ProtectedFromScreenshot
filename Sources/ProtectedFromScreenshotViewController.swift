//
//  ProtectedFromScreenshotViewController.swift
//
//
//  Created by Денис Колеснёв on 19.03.2024.
//

import SwiftUI

public final class ProtectedFromScreenshotViewController<Content: View>: UIViewController {
    
    private let content: () -> Content
    private let wrapperView = ScreenshotProtectedView()
    
    var isProtect: Bool {
        didSet {
            wrapperView.isProtect = isProtect
        }
    }
    
    init(isProtect: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.isProtect = isProtect
        self.content = content
        super.init(nibName: nil, bundle: nil)
        setupUI()
        wrapperView.isProtect = isProtect
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.addSubview(wrapperView)
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wrapperView.topAnchor.constraint(equalTo: view.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let hostingController = UIHostingController(rootView: content())
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingController)
        wrapperView.setupView(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}
