// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

public final class AppCoordinator {
    #if canImport(UIKit)
    private var navigationController: UINavigationController

    public init() {
        self.navigationController = UINavigationController()
        self.navigationController.modalPresentationStyle = .fullScreen
    }
    #else
    private var viewController: NSViewController

    public init() {
        self.viewController = NSViewController()
    }
    #endif

    /// Set the root SwiftUI view for the navigation controller.
    public func setRootView(_ view: some View, setNavBarHidden: Bool = false) -> AnyView {
        #if canImport(UIKit)
        setRoot(view)
        self.navigationController.setNavigationBarHidden(setNavBarHidden, animated: false)
        return AnyView(ViewControllerWrapper(navigationController))
        #else
        let hostingController = NSHostingController(rootView: view)
        self.viewController.view = hostingController.view
        return AnyView(ViewControllerWrapper(viewController))
        #endif
    }

    #if canImport(UIKit)
    private func setRoot(_ view: some View) {
        let hostingController = UIHostingController(rootView: view)
        navigationController.setViewControllers([hostingController], animated: false)
    }

    public func changeRoot(_ view: some View) {
        let hostingController = UIHostingController(rootView: view)
        navigationController.setViewControllers([hostingController], animated: false)
    }

    public func push(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.pushViewController(viewController, animated: animated)
        completion?()
    }

    public func pushSwiftUIView(_ view: some View, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.pushViewController(view.wrapInToViewController(), animated: animated)
        completion?()
    }

    public func pop(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.popViewController(animated: animated)
        completion?()
    }

    public func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }

    public func presentSwiftUIView(_ view: some View, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.present(view.wrapInToViewController(), animated: animated, completion: completion)
    }

    public func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }

    public func backToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }

    public func backToSpecificViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.popToViewController(viewController, animated: animated)
    }

    public func show(vc: UIViewController) {
        navigationController.show(vc, sender: nil)
    }

    public func replaceStack(with viewControllers: [UIViewController], animated: Bool = true) {
        navigationController.setViewControllers(viewControllers, animated: animated)
    }

    public func containsViewController(ofType type: UIViewController.Type) -> Bool {
        return navigationController.viewControllers.contains(where: { $0.isKind(of: type) })
    }

    public func pushIfNotPresent(_ viewController: UIViewController, animated: Bool = true) {
        guard !containsViewController(ofType: type(of: viewController)) else { return }
        push(viewController, animated: animated)
    }

    public var topViewController: UIViewController? {
        return navigationController.topViewController
    }

    public func setCustomTransition(_ animation: CATransition) {
        navigationController.view.layer.add(animation, forKey: kCATransition)
    }
    #endif
}

// MARK: - Extensions for SwiftUI Integration
extension View {
    #if canImport(UIKit)
    public func wrapInToViewController() -> UIViewController {
        return UIHostingController(rootView: self)
    }

    public func wrapInToNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: UIHostingController(rootView: self))
    }
    #else
    public func wrapInToViewController() -> NSViewController {
        return NSHostingController(rootView: self)
    }
    #endif
}

// MARK: - `ViewControllerWrapper`
public struct ViewControllerWrapper: View {
    #if canImport(UIKit)
    private let viewController: UIViewController

    public init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    public var body: some View {
        UIViewControllerRepresentableWrapper(viewController)
    }

    private struct UIViewControllerRepresentableWrapper: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }
    #else
    private let viewController: NSViewController

    public init(_ viewController: NSViewController) {
        self.viewController = viewController
    }

    public var body: some View {
        NSViewControllerRepresentableWrapper(viewController: viewController)
    }

    private struct NSViewControllerRepresentableWrapper: NSViewControllerRepresentable {
        let viewController: NSViewController

        func makeNSViewController(context: Context) -> NSViewController {
            return viewController
        }

        func updateNSViewController(_ nsViewController: NSViewController, context: Context) {}
    }
    #endif
}


