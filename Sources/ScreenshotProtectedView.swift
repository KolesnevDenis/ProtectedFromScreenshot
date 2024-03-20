//
//  ScreenshotPreventingView.swift
//
//
//  Created by Денис Колеснёв on 19.03.2024.
//

import UIKit

final class ScreenshotProtectedView: UIView {
    
    private let textField = UITextField()
    private var contentView: UIView?
    
    private lazy var hiddenContainer: UIView? = {
        let containerName = if #available(iOS 15, *) {
            "_UITextLayoutCanvasView"
        } else {
            "_UITextFieldCanvasView"
        }

        return textField.subviews.first {
            type(of: $0).description() == containerName
        }
    }()

    var isProtect = true {
        didSet {
            textField.isSecureTextEntry = isProtect
        }
    }

    override var isUserInteractionEnabled: Bool {
        didSet {
            hiddenContainer?.isUserInteractionEnabled = isUserInteractionEnabled
        }
    }

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(_ view: UIView) {
        guard let hiddenContainer else {
            return
        }

        self.contentView?.removeFromSuperview()
        self.contentView = view

        hiddenContainer.addSubview(view)
        hiddenContainer.isUserInteractionEnabled = isUserInteractionEnabled
        view.translatesAutoresizingMaskIntoConstraints = false

        let bottomConstraint = view.bottomAnchor.constraint(equalTo: hiddenContainer.bottomAnchor)
        bottomConstraint.priority = .required - 1

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: hiddenContainer.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: hiddenContainer.trailingAnchor),
            view.topAnchor.constraint(equalTo: hiddenContainer.topAnchor),
            bottomConstraint
        ])
    }
    
    private func setupUI() {
        guard let hiddenContainer else {
            return
        }

        textField.backgroundColor = .clear
        textField.isUserInteractionEnabled = false

        addSubview(hiddenContainer)
        hiddenContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hiddenContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            hiddenContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            hiddenContainer.topAnchor.constraint(equalTo: topAnchor),
            hiddenContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        if let contentView {
            setupView(contentView)
            DispatchQueue.main.async {
                self.isProtect = true
            }
        }
    }
}
